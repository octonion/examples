with Ada.Command_Line;
with Ada.Text_IO;

procedure Test is

   Iterations : Positive := Positive'Value
     (Ada.Command_Line.Argument (1));

   protected Buffer is
      entry Put (X : in Boolean);
      entry Get (X : out Boolean);
   private
      Value : Boolean;
      Full : Boolean := False;
   end Buffer;

   protected body Buffer is
      entry Put (X : in Boolean) when not Full is
      begin
         Value := X;
         Full := True;
      end Put;
      entry Get (X : out Boolean) when Full is
      begin
         X := Value;
         Full := False;
      end Get;
   end Buffer;

   task Producer;
   task body Producer is
   begin
      for I in 1 .. Iterations - 1 loop
         Buffer.Put (False);
      end loop;
      Buffer.Put (True);
   end Producer;

   task Consumer;
   task body Consumer is
      X : Boolean;
      Count : Natural := 0;
   begin
      loop
         Buffer.Get (X);
         Count := Count + 1;
         exit when X;
      end loop;
      Ada.Text_IO.Put_Line
        ("Executed " & Natural'Image (Count) & " iterations");
   end Consumer;
   
begin
   null;
end Test;
