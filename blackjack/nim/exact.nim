import math

# Number of decks

const n = 1

# Dealer hits soft 17
const hit_soft_17 = false

# Double after split
const double_after_split = true

# Resplit aces
const resplit_aces = false

var
  deck: array[0..9, int]
  e_o,e_h,e_s: float
  s: string

proc dealer_p(total: int, ace: bool, cards: var array[0..9, int], n: int): array[0..21, float] =

    var
      d, outcomes: array[0..21, float]
      p: float
      
    outcomes = [0.0,0.0,0,0.0,0,0.0,0,0.0,0,0.0,0,0.0,0,0.0,0,0.0,0,0.0,0,0.0,0.0,0.0]
    
    if (total > 21):
        # Dealer busts
        outcomes[0] = 1.0
    elif (total >= 17):
        # Dealer stands
        outcomes[total] = 1.0
    elif ((total==7) and ace and not(hit_soft_17)):
        # Dealer stands on a soft 17
        outcomes[total+10] = 1.0
    elif ((8 <= total) and (total <= 11) and ace):
        # Dealer stands on a soft total > 17
        outcomes[total+10] = 1.0
    else:
        # Dealer hits
        for i in 0..9:
            if (cards[i]>0):
                p = cards[i]/n
                cards[i] += -1
                # Can we speed this up?
                d = dealer_p(total+i+1, (ace or i==0), cards, n-1)
                for j in 0..21:
                    outcomes[j] += p*d[j]
                #l = [p*x for x in dealer_p(total+i+1,(ace or i==0),cards,n-1)]
                #outcomes[:] = [a+b for a, b in zip(outcomes, l)]
                cards[i] += 1
    return outcomes

proc player_p(total: int, ace: bool, cards: var array[0..9, int], dc: int, n: int): (float, float, float) =

    var
      d: array[0..21, float]
      e_o, e_stand, e_hit: float
      p: float

    # Stand
    if (total <= 11 and ace):
        # Stand on total+10
        d = dealer_p(dc,(dc==0),cards,n)
        e_stand = sum(d[0..(total+9)])-sum(d[(total+11)..^1])
    else:
        # Stand on total
        d = dealer_p(dc,(dc==0),cards,n)
        e_stand = sum(d[0..(total-1)])-sum(d[(total+1)..^1])

    # Hit
    e_hit = 0
    for i in 0..9:
        if (cards[i]>0):
            p = cards[i]/n
            if (total+i+1>21):
            # Bust
                e_hit += -p
            else:
                cards[i] += -1
                let (e_o,e_s,e_h) = player_p(total+i+1,(ace or i==0),cards,dc,n-1)
                e_hit += p*e_o
                cards[i] += 1

    return (max(e_hit,e_stand),e_hit,e_stand)

deck = [4*n,4*n,4*n,4*n,4*n,4*n,4*n,4*n,4*n,16*n]

for i in 1..8:
    # Dealer
    deck[i] += -1
    for j in 0..9:
      
        deck[j] += -1
        for k in j..9:
            
            deck[k] += -1
            let (e_o,e_h,e_s) = player_p(j+k+2,(j==0 or k==0),deck,i+1,sum(deck))
            if (e_h>e_s):
                s = "hit"
            else:
                s = "stand"
                
            echo i+1," ",j+1," ",k+1," ",e_h," ",e_s
            deck[k] += 1
        deck[j] += 1
    deck[i] += 1
