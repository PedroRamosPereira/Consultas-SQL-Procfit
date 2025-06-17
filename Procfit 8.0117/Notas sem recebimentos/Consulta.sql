SELECT 
   	nc.NF_COMPRA,
   	nc.pedido_compra,
   	nc.empresa,
	nc.emissao
FROM NF_COMPRA nc
JOIN NF_COMPRA_DIVERGENCIAS_ENTRADA ncde 
	ON nc.NF_COMPRA = ncde.NF_Compra
WHERE 
	nc.recebimento IS NULL 
	AND ncde.aprovacao != 'P'
	AND nc.pedido_compra IS NOT NULL
	AND NOT EXISTS (
		SELECT ps.NF_COMPRA
        	FROM NF_COMPRA_PRODUTOS_SEM_CADASTRO ps
        	WHERE ps.NF_COMPRA = nc.NF_COMPRA
    	)
GROUP BY 
    nc.NF_COMPRA, 
    nc.pedido_compra,
    nc.empresa,
	nc.emissao;