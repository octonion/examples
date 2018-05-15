-- Unit.adb
with Interfaces.C; use Interfaces;
package body Unit is
   function Add (A, B : Integer) return Integer is
   begin
      return A + B;
   end Add;
end Unit;
