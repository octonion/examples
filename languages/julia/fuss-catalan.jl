numterms = 200
C4 = Array{BigInt}(numterms+1) # memoization dictionary
fill!(C4,-1) # -1 implies not yet computed
C4[1] = 1 # Base case for n=0, C[n+1] provides nth term
# memoize partial sums as well
sum2store = similar(C4)
sum3store = similar(C4)
fill!(sum2store, -1)
fill!(sum3store, -1)
function catalan4(n,C)
    C[n+1] == -1 || return C[n+1]
    sum1 = convert(BigInt,0)
    for i in 1:n
        if sum2store[n-i+1] == -1
            sum2 = convert(BigInt,0)
            for j in 1:(n-i+1)
                if sum3store[n-i-j+2] == -1
                    sum3 = convert(BigInt,0)
                    for k in 1:(n-i-j+2)
                        sum3+= catalan4(k-1,C)*catalan4(n-i-j-k+2,C)
                    end
                    sum3store[n-i-j+2] = sum3
                end
                sum2 += catalan4(j-1,C)*sum3store[n-i-j+2]
            end
            sum2store[n-i+1] = sum2
        end
        sum1 += catalan4(i-1,C)*sum2store[n-i+1]
    end
    C[n+1] = sum1
    return sum1
end
for i in 1:numterms
    println(i,"\t",catalan4(200,C4))
end
