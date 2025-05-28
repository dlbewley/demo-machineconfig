# Managing Readable OpenShift MachineConfig Resources

MachineConfigs should make machine management easy and automatic, but MachineConfig resources are not very legible or maintainable. **Don't use them.**

Externalize any substantial text into include files and Use Butane to generate MachineConfigs.