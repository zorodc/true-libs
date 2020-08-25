pragma SPARK_Mode(On);

generic
   type Thing is private;
        Basic:in Thing;
package Stack is
   subtype Count is                     Natural;
   subtype Index is Count range 1 .. Count'Last;

   type Stack (Max_Capacity : Count) is private;
   type Store is array (Index range<>) of Thing;

   -- "Models": For peeking into internals in the spec.
   function Buffer (S : Stack) return Store with Ghost; -- Underlying buffer.
   function Pushes (S : Stack) return Count with Ghost; -- # of items pushed.

   -----------------------
   -- Primary interface --
   -----------------------

   function Has_Space (S : Stack) return Boolean;
   function Has_Items (S : Stack) return Boolean;

   function  Top (S : in   Stack) return Thing
     with Pre  => Has_Items (S),
          Post => Top'Result = Buffer (S)(Pushes (S));

   procedure Pop (S : in out Stack)
     with Pre  => Has_Items (S),
          Post => Has_Space (S) and Pushes (S) = Pushes (S)'Old -1
                                and Buffer (S) = Buffer (S)'Old (1..Pushes(S));

   procedure Put (S : in out Stack; E : Thing)
     with Pre  => Has_Space (S),
          Post => Has_Items (S) and Pushes (S) = Pushes (S)'Old + 1
                                and Buffer (S) = Buffer (S)'Old & E;

private
   type Stack (Max_Capacity : Count) is record
      Elements : Store (1 .. Max_Capacity) := (others => Basic);
      Quantity : Count                     := 0; -- ^ UNNEEDED
   end record
     with Dynamic_Predicate => (Stack.Quantity <= Stack.Max_Capacity);

   function Has_Items(S: Stack) return Boolean is (S.Quantity >              0);
   function Has_Space(S: Stack) return Boolean is (S.Quantity < S.Max_Capacity);
   function Buffer   (S: Stack) return Store   is (S.Elements(1 .. S.Quantity));
   function Pushes   (S: Stack) return Count   is (S.Quantity                 );

end Stack;
