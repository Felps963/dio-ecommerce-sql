SELECT 
    c.id_cliente,
    COALESCE(pf.nome, pj.razao_social) AS nome_cliente,
    COUNT(p.id_pedido) AS total_pedidos
FROM cliente c
LEFT JOIN cliente_pf pf ON c.id_cliente = pf.id_cliente
LEFT JOIN cliente_pj pj ON c.id_cliente = pj.id_cliente
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, nome_cliente
ORDER BY total_pedidos DESC;

SELECT 
    v.id_vendedor,
    v.razao_social AS vendedor_nome,
    f.id_fornecedor,
    f.razao_social AS fornecedor_nome,
    v.cnpj
FROM vendedor v
INNER JOIN fornecedor f ON v.cnpj = f.cnpj;

SELECT 
    p.nome AS produto,
    f.razao_social AS fornecedor,
    e.localizacao AS deposito,
    pe.quantidade AS qtd_estoque
FROM produto p
INNER JOIN produto_fornecedor pf ON p.id_produto = pf.id_produto
INNER JOIN fornecedor f ON pf.id_fornecedor = f.id_fornecedor
INNER JOIN produto_estoque pe ON p.id_produto = pe.id_produto
INNER JOIN estoque e ON pe.id_estoque = e.id_estoque;

SELECT 
    f.razao_social AS fornecedor,
    p.nome AS produto,
    p.categoria
FROM produto p
JOIN produto_fornecedor pf ON p.id_produto = pf.id_produto
JOIN fornecedor f ON pf.id_fornecedor = f.id_fornecedor
WHERE p.categoria = 'Perifericos';

SELECT 
    p.id_pedido,
    c.id_cliente,
    SUM(ip.quantidade * ip.valor_aplicado) AS valor_total_produtos,
    COALESCE(e.valor_frete, 0.00) AS valor_frete,
    (SUM(ip.quantidade * ip.valor_aplicado) + COALESCE(e.valor_frete, 0.00)) AS valor_total_pedido
FROM pedido p
INNER JOIN cliente c ON p.id_cliente = c.id_cliente
INNER JOIN item_pedido ip ON p.id_pedido = ip.id_pedido
LEFT JOIN entrega e ON p.id_entrega = e.id_entrega
GROUP BY p.id_pedido, c.id_cliente, e.valor_frete
HAVING valor_total_pedido > 100.00
ORDER BY valor_total_pedido DESC;