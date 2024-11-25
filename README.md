# fastapi-charts
Repositorio para o helm chart para aplicações da Koda

Get started

Adicionar esse helm repository

```bash
helm repo add arlo-charts https://kodatecnologia.github.io/arlo-charts
```

Instalar o Helm chart

```bash
helm --namespace arlo install arlo-api arlo-charts/arlo-api
helm --namespace arlo install arlo-front arlo-charts/arlo-front
```
