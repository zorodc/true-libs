pragma SPARK_Mode (On);

with Stack;
with Ada.Text_IO; use Ada.Text_IO;

procedure Test is
   package Int_Stack is new Stack (Thing => Integer, Basic => 0);
   S : Int_Stack.Stack (10);
   T : Integer;
begin
   Int_Stack.Put (S, -1);
   Int_Stack.Put (S, -2);
   Int_Stack.Put (S, -3);
   Int_Stack.Put (S, -4);
   Int_Stack.Put (S, -5);

   pragma Assert (Int_Stack.Pushes (S)     =  5); -- Prover can track amounts.
   pragma Assert (Int_Stack.Buffer (S) (5) = -5); -- Prover can track content.
   pragma Assert (Int_Stack.Top    (S)     = -5); -- Prover can track content.

   T := Int_Stack.Top (S);
        Int_Stack.Pop (S);

   -- Ensure tracking functions even after a pop operation.
   pragma Assert (Int_Stack.Pushes (S)     =  4); -- Prover can track amounts.
   pragma Assert (Int_Stack.Buffer (S) (4) = -4); -- Prover can track content.
   pragma Assert (Int_Stack.Top    (S)     = -4); -- Prover can track content.

   Put_Line (Integer'Image (                        T  ));
   Put_Line (Integer'Image (Integer (Int_Stack.Top (S)))); Int_Stack.Pop (S);
   Put_Line (Integer'Image (Integer (Int_Stack.Top (S)))); Int_Stack.Pop (S);
   Put_Line (Integer'Image (Integer (Int_Stack.Top (S)))); Int_Stack.Pop (S);
   Put_Line (Integer'Image (Integer (Int_Stack.Top (S)))); Int_Stack.Pop (S);
end Test;
