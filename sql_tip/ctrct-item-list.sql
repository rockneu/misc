SELECT * FROM SZMETROCONTRACT.DBO.CmContractList
where contractsuppliersuid in (SELECT contractsuppliersuid  FROM SZMETROCONTRACT.DBO.cmcontractsuppliers
                    WHERE CONTRACTUID IN (SELECT CONTRACTUID FROM SZMETROCONTRACT.DBO.CMCONTRACTS
                                   WHERE CONTRACTCODE= 'SZGY05MM202000029' )
			)
--	and listcode in ('300030280010');
				                   --SZGY01MM200000005

--Org_Id = 83
