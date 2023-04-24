# Hydrafy
Pentest script to perform proxy layered or rotating relayed TCP flood on a target

**untested and in its beta test built**

# Install
``nimble install yaml``

### Compile
```
nim compile -d:ssl --threads:on -d:release hydra.nim
```

### Usage
Usage: ./binaryHydra.exe --bytes:<number> --host:<target> --port:<port> --timeoutMS:<timeout>
