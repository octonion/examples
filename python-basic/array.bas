Function arrayDescriptorPtrFunction (Byval p As Any Ptr) As Any Ptr
  Return p
End function
#Define arrayDescriptorPtr(array) _
Cast(Function (() As Typeof((array))) As Any Ptr, @arrayDescriptorPtrFunction)(array())

'------------------------------------------------------------------------------------

Sub printArrayDescriptor (Byval p As Any Ptr)
  Dim As Integer Ptr pu = p
  Print "[@array descriptor: "; pu; "]"
  Print "  @array(all_null_indexes)   ="; pu[0]
  Print "  @array(all_min_indexes)    ="; pu[1]
  Print "  array_total_size_in_bytes  ="; pu[2]
  Print "  array_element_size_in_bytes="; pu[3]
  Print "  number_of_array_dimensions ="; pu[4]
  For i As Integer = 1 to pu[4]
    Print "  [dimension number:"; i; "]"
    Print "    number_of_elements="; pu[5 + (i - 1) * 3]
    Print "    min_index         ="; pu[6 + (i - 1) * 3]
    Print "    max_index         ="; pu[7 + (i - 1) * 3]
  Next i
End Sub

'------------------------------------------------------------------------------------

dim deck(0 to 9) as integer => {4,4,4,4,4,4,4,4,4,16}

print Typeof((deck))

printArrayDescriptor(arrayDescriptorPtr(deck))
Sleep
