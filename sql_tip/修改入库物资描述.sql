
select * from mtl_system_items_b dv where dv.segment1 = '790020010012';
select * from mtl_system_items_tl tl where tl.inventory_item_id =245309 ;
select sg.LONG_DESCRIPTION from Mtl_System_Items_Vl sg where sg.INVENTORY_ITEM_ID = 245309 ;
select rowid,st.* from Rcv_Shipment_Lines st where st.item_id =245309
