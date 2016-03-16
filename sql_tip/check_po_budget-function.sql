PL/SQL Developer Test script 3.0
7
begin
  -- Call the procedure
  cux_inv_bud_pkg.check_po_budget(p_header_id => :p_header_id,
                                  ov_error_msg => :ov_error_msg);
end;


2
p_header_id
1
172711
4
ov_error_msg
0
5
0
