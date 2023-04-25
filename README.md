# Hydrafy
  **TCP DDOS for educational purposes only**<br>
To perform proxy layered or rotating relayed TCP flood,  you have to configure  ``conf.yaml`` config file.

# Install
``nimble install yaml``

### Compile
```
nim compile -d:ssl --threads:on -d:release hydra.nim
```

### Usage
Usage: ``<bin> --bytes:<number> --host:<target> --port:<port>``
