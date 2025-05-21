# Proposta Técnica – WMS Inteligente

## Visão Geral

O WMS Inteligente é um sistema modular de gestão de armazéns projetado para atender indústria, varejo e logística terceirizada. Utiliza RFID, IoT e dashboards em tempo real para garantir precisão operacional e conformidade regulatória.

## Stack Tecnológica

| Camada | Tecnologia |
|--------|------------|
| Frontend | React.js + Material UI |
| Backend | Node.js / NestJS ou Python / FastAPI |
| Banco de Dados | SQL Server |
| IoT | Sensores de temperatura + MQTT/Kafka |
| RFID | Coletores móveis e portais fixos |
| Infraestrutura | Docker + Kubernetes + Azure/AWS |

## Microserviços

| Serviço | Função |
|--------|--------|
| Auth Service | Autenticação e permissões |
| Inventory Service | Controle de estoque |
| RFID Service | Leitura e validação de etiquetas |
| IoT Service | Monitoramento de temperatura |
| Task Manager | Gerenciamento de tarefas |
| Notification Service | Alertas e notificações |

## Metodologia

- Scrum Ágil (sprints de 2 semanas)
- CI/CD via GitHub Actions ou GitLab CI
- Versionamento semântico
- Desenvolvimento orientado a testes (TDD)

## Requisitos Não Funcionais

- Disponibilidade: 99,9%
- Backup diário
- Logs centralizados
- Segurança: JWT, HTTPS, criptografia
