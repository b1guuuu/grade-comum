# grade-comum-backend

## Criando uma instância PostgreSQL com docker

Executar 

```shell
 docker run --name postgresql -e POSTGRES_PASSWORD=[digite uma senha] -e POSTGRES_USER=[digite um usuario] -e POSTGRES_DB=[digite o nome do banco] -d postgres 
```

Os valores inseridos nos [] devem ser preenchidos em um arquivo .env seguindo o modelo do arquivo .env.model