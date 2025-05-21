# Casos de Uso – WMS Inteligente

## UC001 – Recepção com RFID  
**Ator Principal:** Operador de recepção  
**Pré-condição:** Caminhão na doca com mercadoria etiquetada  
**Fluxo Principal:**
1. Leitura RFID das caixas  
2. Sistema compara com pedido de compra  
3. Registro de lote e validade  
4. Alocação dinâmica de posição  
5. Confirmação no sistema  
**Exceções:**  
- Etiqueta inválida → Notificação visual  
- Lote vencido → Impede registro  
- Quantidade diferente → Opção de registrar divergência  

---

## UC002 – Separação de Pedido  
**Ator Principal:** Separador  
**Pré-condição:** Ordem de separação liberada  
**Fluxo Principal:**
1. Liberação de tarefa pelo sistema  
2. Visualização da lista de itens  
3. Rota otimizada exibida no mapa  
4. Leitura RFID dos itens coletados  
5. Confirmação final da tarefa  
**Exceções:**  
- Item não encontrado → Marcar como pendente  
- Erro de leitura → Digitação manual  
- Quantidade insuficiente → Alerta visual  

---

## UC003 – Alerta de Temperatura  
**Ator Principal:** Supervisor  
**Pré-condição:** Sensor de temperatura instalado  
**Fluxo Principal:**
1. Sensor detecta temperatura fora da faixa  
2. Sistema gera notificação  
3. Supervisor recebe alerta no painel  
4. Ação corretiva é registrada  
**Exceções:**  
- Falha no sensor → Notificação técnica  
- Temperatura volta ao normal → Fechamento automático  

---

## UC004 – Inventário Cíclico  
**Ator Principal:** Supervisor  
**Pré-condição:** Sistema programado para inventário rotativo  
**Fluxo Principal:**
1. Sistema seleciona localizações aleatórias  
2. Tarefa criada para operador  
3. Leitura RFID dos itens  
4. Sistema compara com estoque registrado  
5. Divergências são destacadas  
**Exceções:**  
- Local sem acesso → Reagendar  
- Itens faltando → Registrar ajuste  
- Erro no sistema → Relatório técnico  

---

## UC005 – Gestão de Lotes  
**Ator Principal:** Gestor de estoque  
**Pré-condição:** Produto perecível cadastrado  
**Fluxo Principal:**
1. Registro de novo lote  
2. Definição de data de fabricação e validade  
3. Alocação no estoque  
4. Sistema prioriza saída por FIFO  
5. Lote vencido é bloqueado automaticamente  
**Exceções:**  
- Lote danificado → Exclusão manual  
- Alteração de validade → Justificativa obrigatória  
