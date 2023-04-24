# Hydrafy
**TCP SYN flood for educational purposes only**
Pentest script to perform proxy layered or rotating relayed TCP flood on a target when ``server.yaml`` is configured.

**untested and in its beta test built**

# Install
``nimble install yaml``

### Compile
```
nim compile -d:ssl --threads:on -d:release hydra.nim
```

### Usage
Usage: ``<bin> --bytes:<number> --host:<target> --port:<port> --timeoutMS:<timeout>``
