# Documentação Interna – WMS Inteligente

## Estrutura do Projeto

## Padrões de Código

- Linguagem: TypeScript ou Python
- Estilo: Prettier / Black
- Commits: Convenção de commits semânticos
- Branches: main, develop, feature/*

## Ambientes

| Ambiente | URL | Observações |
|----------|-----|-------------|
| Local | http://localhost:3000 | Desenvolvimento local |
| Homologação | https://homolog.wms.interno  | Testes internos |
| Produção | https://app.wms.com  | Ambiente final de produção |

## Processo de Deploy

1. Desenvolvimento local
2. Pull Request no GitHub
3. Testes automatizados
4. Deploy automático via CI/CD
5. Validação manual
