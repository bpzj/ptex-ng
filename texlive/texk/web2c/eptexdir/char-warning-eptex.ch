% $Id: char-warning-eptex.ch 55874 2020-07-19 15:42:51Z karl $
% Public domain. See ../pdftexdir/char-warning-pdftex.ch for info.

@x [30] If \tracinglostchars > 2, then promote full errors.
@p procedure char_warning(@!f:internal_font_number;@!c:eight_bits);
var @!l:0..255; {small indices or counters}
old_setting: integer; {saved value of |tracing_online|}
begin if tracing_lost_chars>0 then
 begin old_setting:=tracing_online;
 if eTeX_ex and(tracing_lost_chars>1) then tracing_online:=1;
  begin begin_diagnostic;
  print_nl("Missing character: There is no ");
@.Missing character@>
  if (c<" ")or(c>"~") then
    begin print_char("^"); print_char("^");
    if c<64 then print_char(c+64)
    else if c<128 then print_char(c-64)
    else begin print_lc_hex(c div 16);  print_lc_hex(c mod 16); end
    end
  else print_ASCII(c);
  print(" in font ");
  slow_print(font_name[f]); print_char("!"); end_diagnostic(false);
  end;
 tracing_online:=old_setting;
 end;
end;
@y
@p procedure char_warning(@!f:internal_font_number;@!c:eight_bits);
var @!l:0..255; {small indices or counters}
old_setting: integer; {saved value of |tracing_online|}
begin if tracing_lost_chars>0 then
 begin old_setting:=tracing_online;
 if eTeX_ex and(tracing_lost_chars>1) then tracing_online:=1;
 if tracing_lost_chars > 2 then
   print_err("Missing character: There is no ")
 else begin
   begin_diagnostic;
   print_nl("Missing character: There is no ")
 end;
@.Missing character@>
 if (c<" ")or(c>"~") then begin
   print_char("^"); print_char("^");
   if c<64 then print_char(c+64)
   else if c<128 then print_char(c-64)
        else begin print_lc_hex(c div 16);  print_lc_hex(c mod 16); end
             end
 else print_ASCII(c);
 if tracing_lost_chars > 2 then begin
   print(" (");
   print_hex(c);
   print(")");
 end;
 print(" in font ");
 slow_print(font_name[f]);
 if tracing_lost_chars < 3 then print_char("!");
 tracing_online:=old_setting;
 if tracing_lost_chars > 2 then begin
   help0;
   error;
 end else end_diagnostic(false);
 end; {of |tracing_lost_chars>0|}
end;  {of procedure}
@z
