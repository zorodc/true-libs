pragma SPARK_Mode(On);

package body Stack is
   function  Top (S : in     Stack) return Thing is (S.Elements (S.Quantity));
   procedure Pop (S : in out Stack) is
   begin S.Quantity := S.Quantity - 1; end Pop;

   procedure Put (S : in out Stack; E : Thing) is
   begin
	  S.Quantity := S.Quantity + 1;
	  S.Elements (S.Quantity) := E;
   end Put;

end Stack;
