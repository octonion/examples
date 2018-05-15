import groovy.transform.CompileStatic
 
@CompileStatic
class Test{
    def test(){
       def name = ["test":"test2"]
       name.substring(0,3)
       //throw a compile time error as name is not string
       //at compile time
    }
 
}
println "Code in this file is statically compiled"
