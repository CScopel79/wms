# Projeto MVP – WMS Inteligente  
## Mínimo Produto Viável

### 🎯 Objetivo do MVP
Validar o conceito do sistema de gestão de armazéns com funcionalidades básicas, baixo custo de desenvolvimento e rápida iteração com usuários reais.

---

### 🧩 Escopo do MVP

#### Módulos Prioritários:
1. **Cadastro de Produtos**
   - Código, nome, descrição, peso, volume
   - Definição se é perecível ou sensível à temperatura

2. **Recepção com RFID Básico**
   - Leitura de etiquetas RFID
   - Conferência com pedido de compra
   - Registro manual de lote e validade

3. **Estoque Básico**
   - Visualização do estoque por localização
   - Histórico de movimentações
   - Controle de quantidade

4. **Separação de Pedidos (Picking)**
   - Liberação de tarefas
   - Rota básica de separação
   - Confirmação de coleta

5. **Dashboard Inicial**
   - KPIs básicos: precisão de estoque, tempo médio de picking
   - Mapa de ocupação do armazém

6. **Integração Básica com ERP**
   - Cadastro de produtos sincronizado
   - Pedidos de venda importados

---

### ⚙️ Tecnologias Envolvidas

| Camada | Tecnologia |
|--------|------------|
| Frontend | React.js + Material UI |
| Backend | Node.js / NestJS ou Python / FastAPI |
| Banco de Dados | SQL Server |
| RFID | Coletores móveis simples |
| IoT | Simulação de sensores (implementação futura) |
| Infraestrutura | Azure App Service / AWS Amplify |

---

### 👥 Time Necessário

| Função | Atividade |
|--------|-----------|
| Product Owner | Alinhar requisitos e priorizar backlog |
| Frontend Developer | Desenvolver interface web e mobile |
| Backend Developer | Criar APIs e integrações |
| QA Tester | Validar fluxos e testes funcionais |
| UX Designer | Garantir usabilidade das telas |

---

### 📅 Cronograma de Desenvolvimento

| Fase | Descrição | Tempo |
|------|-----------|-------|
| 1 | Levantamento de requisitos | 2 semanas |
| 2 | Protótipo e UI/UX inicial | 3 semanas |
| 3 | MVP funcional (funcionalidades acima) | 8 semanas |
| 4 | Testes e ajustes iniciais | 2 semanas |
| Total |  | **~15 semanas (~3,5 meses)** |

---

### 💰 Custo Estimado do MVP

| Item | Descrição | Valor estimado |
|------|-----------|----------------|
| Equipe técnica | 3 devs + PO | R$ 90.000 |
| Infraestrutura | Hospedagem cloud | R$ 5.000 |
| Dispositivos teste | Coletores RFID | R$ 8.000 |
| Design e UX | Interface inicial | R$ 7.000 |
| Total |  | **R$ 110.000** |

---

### 🚀 Próximos Passos Após MVP

- Captação de clientes piloto
- Feedback e iterações
- Planejamento da versão completa com IoT e automação avançada
- Lançamento comercial

---

### 📈 Resultados Esperados após MVP

| Métrica | Antes (hipotético) | Após MVP |
|--------|---------------------|----------|
| Tempo médio de picking | 12 min/pedido | 8 min/pedido |
| Precisão de estoque | ~85% | ~95% |
| Taxa de erro de expedição | ~3% | <1% |
| Retrabalho operacional | Alto | Reduzido em 40% |
