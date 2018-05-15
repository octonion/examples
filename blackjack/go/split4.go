package main

import (
	"fmt"
	"github.com/BenLubar/memoize"
	"os"
	/*"log"*/
	"encoding/csv"
	/*"strconv"*/
)

/* Decks */

const decks = 1

const hit_soft_17 = false

var dealer_p func(total int,first bool,ace bool,cards [10]int) ([22]float64)

func init() {

	dealer_p = memoize.Memoize(func(total int,first bool,ace bool,cards [10]int) ([22]float64) {

		var outcomes [22]float64

		switch {
		case total > 21:
			/* Bust */
			outcomes[0] = 1.0
		case total >= 17:
			/* Stand */
			outcomes[total] = 1.0
		case (total==7) && ace && !(hit_soft_17):
			/* Stand */
			outcomes[total+10] = 1.0
		case (8 <= total && total <= 11) && ace:
			/* Stand */
			outcomes[total+10] = 1.0
		default:
			var low int
			var high int
			var p float64
			var n float64

			/* Hit */

			/* No blackjack */

			low = 0
			high = 10

			n = 0.0
			for i := low; i < high; i++ {
				n += float64(cards[i])
			}

			for i := low; i < high; i++ {
				if (cards[i] > 0) {
					p = float64(cards[i])/n
					cards[i] += -1
					d := dealer_p(total+i+1,false,(ace||i==0),cards)
					for j := 0; j < 22; j++ {
						outcomes[j] += p*d[j]
					}
					cards[i] += 1
				}
			}

		}

		return(outcomes)
			
	}).(func(total int,first bool,ace bool,cards [10]int) ([22]float64))

}

var player2_p func(total int,total1 int,ace bool,cards [10]int,dc int) (float64,float64)

func init() {

	player2_p = memoize.Memoize(func(total int,total1 int,ace bool,cards [10]int,dc int) (float64,float64) {

		var e_stand float64 = 0.0
		var e_hit float64 = 0.0

		/* Stand */
		if total <= 11 && ace {
			d := dealer_p(dc+1,true,(dc==0),cards)
			for i := 0; i < total+10; i++ {
				e_stand += d[i]
			}
			for i := total+11; i < 22; i++ {
				e_stand += -d[i]
			}
			if total1<=21 {
				for i := 0; i < total1; i++ {
					e_stand += d[i]
				}
				for i := total1+1; i < 22; i++ {
					e_stand += -d[i]
				}
			} else {
				e_stand += -1.0
			}
		} else {
			d := dealer_p(dc+1,true,(dc==0),cards)
			for i := 0; i < total; i++ {
				e_stand += d[i]
			}
			for i := total+1; i < 22; i++ {
				e_stand += -d[i]
			}
			if total1<=21 {
				for i := 0; i < total1; i++ {
					e_stand += d[i]
				}
				for i := total1+1; i < 22; i++ {
					e_stand += -d[i]
				}
			} else {
				e_stand += -1.0
			}
		}

		/* Hit */

		/*
                Dealer can't have a 10 if showing A
                Dealer can't have an A if showing 10
                Need to adjust p in those cases
                n cards
                a aces
                  subtract cards[i]/(n-a) from each non-A
                  renormalize
                a = cards[0]
                c = cards[1]
                a/(n-1)
                s = 1-a/(n-1) = (n-a-1)/(n-1)
                (c/(n-a))*((n-a-1)/(n-1))
                p[0] = cards[0]/(n-1)
                p[i>0] = (c-c/(n-a))/(n-1)
                     = c*((n-a-1)/(n-a))/(n-1)
                sum to (n-a)*((n-a-1)/(n-a))/(n-1) = (n-a-1)/(n-1)
                a/(n-1)+(n-a-1)/(n-1) = (n-1)/(n-1) = 1

                */

		var n float64 = 0.0
		var p float64 = 0.0
		
		for i := 0; i < 10; i++ {
			n += float64(cards[i])
		}

		for i := 0; i < 10; i++ {
			if cards[i]>0 {
				
				/*fmt.Println(i,dc,a,m,p,cards)*/
				var m float64 = float64(cards[i])
				var a float64 = float64(cards[9-dc])
				
				switch {
				case (dc==0 || dc==9) && (dc+i==9):
					p = m/(n-1)
				case (dc==0 || dc==9) && !(dc+i==9):
					p = (m/(n-a))*(n-a-1)/(n-1)
				default:
					p = m/n
				}

				/* Bust */
				if total+i+1 > 21 {
					e_hit += -p
					cards[i] += -1
					d := dealer_p(dc+1,true,(dc==0),cards)
					if total1<=21 {
						for i := 0; i < total1; i++ {
							e_hit += p*d[i]
						}
						for i := total1+1; i < 22; i++ {
							e_hit += -p*d[i]
						}
					} else {
						e_hit += -p
					}
					cards[i] += 1
				} else {
					cards[i] += -1
					e_h,e_s := player2_p(total+i+1,total1,(ace||i==0),cards,dc)
					if (e_h>=e_s) {
						e_hit += p*e_h
					} else {
						e_hit += p*e_s
					}
					
					cards[i] += 1
				}
			}
		}

		return e_hit,e_stand
		
	}).(func(total int,total1 int,ace bool,cards [10]int,dc int) (float64,float64))
}

var player_p func(total int,ace bool,ace2 bool,cards [10]int,dc int) (float64,float64)

func init() {

	player_p = memoize.Memoize(func(total int,ace bool,ace2 bool,cards [10]int,dc int) (float64,float64) {

		var e_stand float64 = 0.0
		var e_hit float64 = 0.0

		/*
		if total <= 11 && ace {
			d := dealer_p(dc+1,true,(dc==0),cards)
			for i := 0; i < total+10; i++ {
				e_stand += d[i]
			}
			for i := total+11; i < 22; i++ {
				e_stand += -d[i]
			}
		} else {
			d := dealer_p(dc+1,true,(dc==0),cards)
			for i := 0; i < total; i++ {
				e_stand += d[i]
			}
			for i := total+1; i < 22; i++ {
				e_stand += -d[i]
			}
		}
*/
		var r int = 0
		for i := 0; i < 9; i++ {
			r += (i+1)*(4*decks-cards[i])
		}
		r += 10*(16*decks-cards[9])
		var t2 int = r-(dc+1)-total

		var e_h2 float64 = 0.0
		var e_s2 float64 = 0.0

		/*fmt.Println(total,r,t2,false,cards,dc)*/
		if (total<=11 && ace) {
			e_h2,e_s2 = player2_p(t2,total+10,ace2,cards,dc)
		} else {
			e_h2,e_s2 = player2_p(t2,total,ace2,cards,dc)
		}
/*		if (e_h2<=e_s2) {
			fmt.Println("stand",e_h2,e_s2)
		}*/
		
		var e_o2 float64 = e_h2
		if (e_s2 > e_o2) {
			e_o2 = e_s2
		}
		e_stand = e_o2

		/* Hit */

		var n float64 = 0.0
		var p float64 = 0.0
		
		for i := 0; i < 10; i++ {
			n += float64(cards[i])
		}

		for i := 0; i < 10; i++ {
			if cards[i]>0 {

				var m float64 = float64(cards[i])
				var a float64 = float64(cards[9-dc])
				
				switch {
				case (dc==0 || dc==9) && (dc+i==9):
					p = m/(n-1)
				case (dc==0 || dc==9) && !(dc+i==9):
					p = (m/(n-a))*(n-a-1)/(n-1)
				default:
					p = m/n
				}
				
				/*fmt.Println(i,dc,a,m,p,cards)*/
				
				if total+i+1 > 21 {
					/* Bust */
					/*e_hit += -p*/

					r = 0
					for i := 0; i < 9; i++ {
						r += (i+1)*(4*decks-cards[i])
					}
					r += 10*(16*decks-cards[9])
					t2 = r-(dc+1)-total

					cards[i] += -1
					e_h2,e_s2 := player2_p(t2,total+i+1,ace2,cards,dc)
					cards[i] += 1
/*					if (e_h2<=e_s2) {
						fmt.Println("hit/bust",e_h2,e_s2)
					}*/
					e_o2 = e_h2
					if (e_s2 >= e_o2) {
						e_o2 = e_s2
					}
					
					e_hit += p*e_o2
				} else {
					cards[i] += -1
					e_h,e_s := player_p(total+i+1,(ace||i==0),ace2,cards,dc)
					cards[i] += 1
					if (e_h >= e_s) {
						e_hit += p*e_h
					} else {
						e_hit += p*e_s
					}
					
				}
			}
		}

		return e_hit,e_stand
		
	}).(func(total int,ace bool,ace2 bool,cards [10]int,dc int) (float64,float64))
}
		
func main() {

	var deck [10]int

	for i := 0; i < 9; i++ {
		deck[i] = decks*4
	}
	deck[9] = decks*16

	outfile, err := os.Create("results.csv")
	_ = err
	writer := csv.NewWriter(outfile)
	defer writer.Flush()

	for i:=1; i<2; i++ {
		deck[i] += -1
		
		/*var n float64 = 0.0
		for h := 0; h < 10; h++ {
			n += float64(deck[i])
		}*/

		for j:=1; j<10; j++ {
			deck[j] += -2
			var e float64 = 0.0
			for k := 0; k<10; k++ {
				p1 := float64(deck[k])/float64(52*decks-3)
				deck[k] += -1
				for l:=0; l < 10; l++ {
					if deck[l] <= 0 {
						continue
					}
					p2 := float64(deck[l])/float64(52*decks-4)
					deck[l] += -1
					e_h,e_s := player_p(j+k+2,(j==0)||(k==0),(j==0)||(l==0),deck,i)
					if (e_h>=e_s) {
						e += p1*p2*e_h
					} else {
						e += p1*p2*e_s
					}
					deck[l] += 1
				}
				deck[k] += 1
			}
			deck[j] += 2
			fmt.Println(i+1,j+1,e)
		}
		deck[i] += 1
	}
}
