> [!WARNING]
> **These MachineConfig resources are generated from Butane [`*.bu` files](butane/).**
>
> Do not edit the MachineConfig `*.yaml` files directly.

**Instructions:**

* Make any required changes to the `*.bu` files.
* Make any required changes to the [included files](inc/).
* Run `make` to generate the new MachineConifg YAMLs.
* `oc apply -k .` them or just commit the changes and let ArgoCD and gitops take the wheel.
