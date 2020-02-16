# Building Intake

```bash
# Prod version of the image
docker build --target prod -t intake:local .

# Prod version of the image including dev scripts
docker build --target dev -t intake:local .
```
