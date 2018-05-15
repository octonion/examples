-- Unit.ads
with Interfaces.C; use Interfaces;
package Unit is
   function Add (A, B : Integer) return Integer;
   pragma Export (C, Add, "add");
end Unit;
