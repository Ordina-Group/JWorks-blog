---
layout: post
authors: [pieter_vincken]
title: 'Kustomize: Kubernetes configuration management, the easy way'
image: /img/2019-09-09-kustomize/banner.png
tags: [Kustomize, Configuration Management, Kubernetes, Cloud]
category: Cloud
comments: true
---

### Reading time: 8 min 29 sec

# Table of contents

* [What problem do we have?](#what-problem-do-we-have)
* [What alternatives are available to solve this problem?](#what-alternatives-are-available-to-solve-this-problem)
* [What is Kustomize and how to use it](#what-is-kustomize-and-how-to-use-it)
* [Extending Kustomize](#extending-kustomize-plugins)
* [Conclusion](#conclusion-when-to-use-kustomize)

## What problem do we have?

Deploying components to a Kubernetes cluster should be as easy as running `kubectl apply -f folder-with-deployment-manifests`.
This approach works very well for a single environment, but quickly become very hard to do properly when managing multiple environments (Dev, Staging, ..., Production).
The reason for this is due to the configuration differences in these environments.
Every environment needs a different configuration to: connect to different databases, use other secret values, use different deployment configurations (number of replicas for example), ...
Managing these differences can be very hard to do in a single set of manifests.

## What alternatives are available to solve this problem?

Luckily this problem exists in many organizations and the community already created multiple tools to help solve the problem.
In the scope of configuration management for Kubernetes the following tools are in available:

* [OpenShift Templates](https://docs.openshift.com/container-platform/4.1/welcome/index.html){:target="_blank" rel="noopener noreferrer"}
* [Helm 2](https://helm.sh/){:target="_blank" rel="noopener noreferrer"}
* [Helm 3](https://v3.helm.sh/){:target="_blank" rel="noopener noreferrer"}
* [Kustomize](https://kustomize.io/){:target="_blank" rel="noopener noreferrer"}

OpenShift Templates are part of the OpenShift platform and can be used both to template manifests in a repository and to provide an off-the-shelve experience in the OpenShift platform itself.
For example, a cluster administrator can install a template for an Apache Kafka setup.
By provisioning this template (through the online UI or the CLI) and providing the required template values, the service can be provisioned like the administrator provides it.
This is a very powerful approach to allow developers to provision supporting systems directly in the platform.

Helm 2 is a templating and deployment management tool.
In Helm 2 a server-side component needs to be installed in the cluster named Tiller.
Tiller is the central entrypoint and management component for all deployments using Helm 2.
It keeps the state of all deployed manifests and groups them together as a single release.
The main disadvantage of Helm 2 is the lack of proper authorization (RBAC) support as Tiller will run with almost root-level privileges on the cluster.

Helm 3 is currently still in beta, but the reworked version should resolve a lot of the issues with Helm 2.
Like Helm 2 it's still a templating engine which also manages releases.
Unlike Helm 2, it doesn't use the Tiller component anymore to manage all the state connected to the release.
More information about Helm can be found in a future blogpost.

Kustomize is a Kubernetes configuration management tool that is provided as part of the `kubectl` command, behind the `-k` flag.
Kustomize allows a user to use standard Kubernetes manifests and overlay any changes that they want to make using an overlay manifest.
Unlike Helm, Kustomize only provides configuration management and doesn't manage any state about the manifests it adapts.
Unlike Helm and OpenShift Templates, the main goal of Kustomize is to allow users to adapt their existing manifests in any thinkable way, instead of templating some parts of the manifest that can be changed.

## What is Kustomize and how to use it

As briefly discussed, Kustomize is a configuration management tool that has been embedded into `kubectl`.
Originally it was a separate tool and some functionality is still only available in the Kustomize binary and not in Kubectl.
The documentation of Kustomize is therefore available in two parts, the [core docs](https://github.com/kubernetes-sigs/kustomize/tree/master/docs){:target="_blank" rel="noopener noreferrer"} and the [Kubectl docs](https://kubectl.docs.kubernetes.io/pages/app_management/introduction.html){:target="_blank" rel="noopener noreferrer"}.

Important to note, especially when considering the usage of this tool, is what it doesn't do:

* It doesn't manage deployments
* It doesn't package applications in deployable artifacts
* It doesn't manage secrets securely

As discussed in the Kustomize projects [readme](https://github.com/kubernetes-sigs/kustomize/){:target="_blank" rel="noopener noreferrer"} a Kustomize manifest exists out of two main structures: a base manifest and overlays.

### Base manifest

A base manifest is, in essence, a set of bare-bones Kubernetes manifests with some Kustomize configuration.
For the scope of this blog post, a single base manifest will contain all configuration to deploy a single service.
Kustomize doesn't require this, but it seems like a good fit.

Let's assume the following set of Kubernetes manifests:
```
├── deployment.yaml
├── ingress.yaml
└── service.yaml
```

These manifests can deploy one of our apps to a cluster.
It will create a deployment, a service exposing the app to the cluster and an ingress object that will allow connections from outside of the cluster.
Managing a set of these manifests in separate files or even in one file, can be a bit challenging and often results in violating the Don't-Repeat-Yourself (DRY) principle.
Kustomize can assist in preventing this and allows the user to more generally manage their manifests.
Adding Kustomize to a set of manifests is as easy as creating a `kustomization.yaml` file and running `kustomize build`.

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

# Add labels to all objects created by this kustomize manifest.
commonLabels:
    app: task-service

resources:
- deployment.yaml
- service.yaml
- ingress.yaml
```

In this example, only a single feature of Kustomize is used, namely the `commonLabels` option.
This option makes Kustomize add the label to all managed manifests at build time (when running `kubectl apply -k` or `kustomize build`).
Other options like image overrides, namespaces overrides and name prefixing are also available.
For more information on these features check out the documentation [here](https://kubectl.docs.kubernetes.io/pages/app_management/introduction.html){:target="_blank" rel="noopener noreferrer"}.

### Overlay manifest

The second half of the cake in Kustomize are the overlays.
Overlays are YAML snippets, Kustomize configuration and/or even full manifests that can be used to adapt a base manifest.

In the default setup on the Kustomize homepage, the bases are always local folders.
However, a really useful feature is referencing remote locations, including Git repositories, as bases to be used in an overlay.
The Git endpoints need to be specified as described in the [hashicorp/go-getter URL format](https://github.com/hashicorp/go-getter#url-format){:target="_blank" rel="noopener noreferrer"}.
Important to note here is that when using the Git references, the machine that is executing Kustomize builds needs to have a valid Git configuration to access the referenced repositories.
As the kustomization file is checked into version control, adding credentials into the link is considered a bad practice.
Kustomize supports referencing multiple bases, which again allows for a lot of flexibility.
The references work recursively, so multiple levels of manifests are supported.
At the time of writing, diamond composition is not possible but [being worked on](https://github.com/kubernetes-sigs/kustomize/issues/1251){:target="_blank" rel="noopener noreferrer"}.

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- ../../base
- git::ssh://git@some-git-provider:some-repo-path.git//folder-in-repo-with-kustomize-config?ref=some-branch
- github.com/project/repo//folder-in-repo?ref=branch
...
```

The example above uses 3 different ways to include a base manifest in this overlay.
The first one, `../../base`, references a folder on the machine.
A kustomization manifest needs to be present in this folder.

The second one, `git::ssh://git@some-git-provider:some-repo-path.git//folder-in-repo-with-kustomize-config?ref=some-branch` points to a Git repository.
More specifically, it points to the Git repository name `some-repo-path` on git provider `some-git-provider`.
It connects to that Git provider using SSH (`ssh://`) and it will checkout the branch named `some-branch`.
Finally, it will look for the kustomization manifest in the `folder-in-repo-with-kustomize-config` folder of the repository instead of in the root directory.

The last method is very similar to the second, however it uses the github.com specific syntax.

The way Kustomize builds a set of manifests is the following:

1. Download the remote bases to a temporary folder
1. Executed `kustomize build` on all of the bases
    1. This will include executing any generators and transformers that are configured in the bases.
1. Add any manifests that are listed in the resources section.
1. Execute the generators.
1. Apply any patches and execute the transformers against all manifest that are generated or available through the bases.

This order of execution is important to remember when creating setups, especially when using overrides for generators in the base.
E.g. when using a config map generator in the overlay, a ConfigMap generator needs to be used in the base as well, otherwise Kustomize will not allow the override to be executed.
This is because the config map generator adds a random ID to the name of each generated config map and cannot determine whether to change the config maps in the base template as well.

## Extending Kustomize: plugins

In some examples the `configMapGenerator` was used to easily create config maps without having to manually convert files.
There are actually two mechanisms to influence YAML files programmatically: generators and transformers.

Generators do exactly what their name suggests: they generate YAML files.
Generator will use the provided configuration to create new manifests and add them to the set of already available Kubernetes manifests.

Transformers however only work on existing Kubernetes manifests.
The `commonLabels` option used in the code snippets above is an example of a transformer.
It doesn't create new manifests, it only changes existing ones.

There are a few built-in generators and transformers provided with Kustomize, but the real power lays within the creation of custom plugins that can act as either generators or transformers.

### Plugins

Kustomize allows plugins to be created and used during execution.
This mechanism allows for a lot of flexibility.
Currently, plugins are still an alpha feature and therefore not available through `kubectl` but only through the `kustomize` tool itself.

Writing a plugin can be done in one of two ways:

* Write a plugin in Go and link it as a shared library to the Kustomize tool
* Write a plugin based on the exec model

While the first way allows the code to be more easily absorbed into the Kustomize binary later on, it requires the plugin to be compiled together with the `kustomize` binary.
The second option is a lot more flexible as it only relies on the plugin being available and providing a very rudimentary interface.
More information on support for plugins can be found in the [docs](https://github.com/kubernetes-sigs/kustomize/tree/master/docs/plugins){:target="_blank" rel="noopener noreferrer"} and examples can be found [here](https://github.com/Agilicus/kustomize-plugins){:target="_blank" rel="noopener noreferrer"}.

## Real-world example

In the last section of this post, a simple example setup will be shown and discussed.
Consider the following scenario: a UI, two backends (task service and process service) and a datastore.
The components have deployments, services, ConfigMaps ,and ingress manifests.
This would result in the following structure:

Let's assume the following set of Kubernetes manifests:
```
frontend/
├── deployment.yaml
├── ingress.yaml
├── configmap.yaml
└── service.yaml

task-service/
├── deployment.yaml
├── ingress.yaml
├── configmap.yaml
└── service.yaml

process-service/
├── deployment.yaml
├── ingress.yaml
├── configmap.yaml
└── service.yaml
```

Deploying this application is as easy as running `kubectl apply -f <folder>` on each of these folders.
A very simple use case for Kustomize is to deploy all of these components at once and group them.
The following `kustomization.yaml` should be added to each folder.

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- deployment.yaml
- service.yaml
- ingress.yaml
- configmap.yaml
```

The following Kustomization manifest could then be used to deploy everything at once by running `kubectl apply -k acceptance/`

`acceptance/kustomization.yaml`
```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- ../frontend
- ../task-service
- ../process-service
```

During the execution of this command, Kustomize will generate a single (giant) file containing all the manifests.
Note that the bases are referenced under the resources.
The `bases` key is deprecated and all references should be moved into the resources key.

Making variants on the actual bases is super easy.
For example, let's assume that the acceptance environment needs a different configuration.
This can be achieved by just overriding the ConfigMap in the acceptance folder.
There are three different ways to override a ConfigMap.

### Using ConfigMap Generator

Generators can be used to ease the management of configuration.
The ConfigMap generator makes creating ConfigMaps easier by providing a more common way to specify configuration.
More information on the ConfigMap generator can be found [here](https://kubectl.docs.kubernetes.io/pages/reference/kustomize.html#configmapgenerator){:target="_blank" rel="noopener noreferrer"}.

`acceptance/kustomization.yaml`
```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- ../frontend
- ../task-service
- ../process-service

configMapGenerator:
- name: task-service
  env:
    - loglevel=warn
```

The ConfigMap generator will look for the original manifest and apply the override.
Important to note here is that the generator only works if the original manifest was generated as well.
Using this approach thus requires both the base and overrides to use the generator.
A nice bonus to using the generator is that it will add unique IDs to the ConfigMap name every time one is generated.
This way, a component is automatically updated when a linked ConfigMap is changed.
This provides a nice way to prevent manually triggering a rolling update when configuration changes.

Currently only ConfigMap and secret generators are available by default, but as mentioned, there is a very good plugin mechanism available to add more.

### Using patches

Patches are the last way to override a configuration from a base.
Patches are available in two flavors: Json6902 and Strategic Merge.

Json6902 is an RFC standard provided by the [IETF](https://tools.ietf.org/html/rfc6902){:target="_blank" rel="noopener noreferrer"} to describe JSON patches.
In a nutshell, operations (patches) can be described using JSON path, operations ,and values.

For the example earlier, this would result in the following:
`acceptance/kustomization.yaml`
```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- ../frontend
- ../task-service
- ../process-service

patches:
- target:
    version: v1
    kind: ConfigMap
    name: task-service
  path: configs/acceptance-specific-task-service-configmap-patch.yaml
```

`acceptance/configs/acceptance-specific-task-service-configmap-patch.yaml`
```yaml
 - op: replace
   path: /data/loglevel
   value: warn
```

Matching is done based on the name (`metadata.name`), version and kind of the resource.
This approach will result in the acceptance-specific config map overriding the base task-service ConfigMap.
It will result in the same ConfigMap manifest after the `kustomize build`.

The strategic merge is the final way to provide an override in Kustomize.
It merges the existing ConfigMaps with the new configuration provided in the override.
It applies the same matching rules as the JSON patch approach to match base manifests with the overrides.
Note that the configuration will be added or overridden.

`acceptance/kustomization.yaml`
```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- ../frontend
- ../task-service
- ../process-service

patches:
- patches/acceptance-specific-task-service-configmap.yaml
```

`acceptance/patches/acceptance-specific-task-service-configmap.yaml`
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: task-service
data:
  loglevel: warm
```

Building this Kustomize manifest will again result in the same Kubernetes ConfigMap manifest as the other two approaches.
Note that none of the three approaches required changing the original manifests.
When multiple variants are created, updates to the base will automatically be added to all variants without having to change a single line of code.

## Conclusion: When to use Kustomize?

Kustomize is a great tool to have in your toolbox to simplify configuration management in Kubernetes.
DRY principles can be adhered to and managing configuration code can be done in a structured and unified way.
Kustomize is a great fit when different environments require different configuration for a microservice.
Especially when sensible defaults can be added to the base template and only a small amount of overrides are required per environment.
When compared to Helm, both version 2 and 3, Kustomize doesn't pollute the original manifests with templating code.

Kustomize is a configuration management tool for Kubernetes.

* Have a lot of configuration code being duplicated across environments?
* Have a complex CD setup with manual steps to deploy configuration to a specific environment?
* Hate using templating engines?
* Really really really like using Kubernetes?

If all of the above are true for you, start using Kustomize today and experience it yourself!

## Useful links

* [Kubectl-Kustomize docs](https://kubectl.docs.kubernetes.io/pages/app_management/introduction.html){:target="_blank" rel="noopener noreferrer"}
* [Kustomize core docs](https://github.com/kubernetes-sigs/kustomize/tree/master/docs){:target="_blank" rel="noopener noreferrer"}
* [Kustomize plugins](https://github.com/kubernetes-sigs/kustomize/tree/master/docs/plugins){:target="_blank" rel="noopener noreferrer"}
* [Kustomize plugin examples](https://github.com/Agilicus/kustomize-plugins){:target="_blank" rel="noopener noreferrer"}
* [ConfigMap Generator](https://kubectl.docs.kubernetes.io/pages/reference/kustomize.html#configmapgenerator){:target="_blank" rel="noopener noreferrer"}
