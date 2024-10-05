reset

set xlabel "x1"
set ylabel "x2"

set grid

set xrange [-0.5:2.5]
set yrange [-1.2:1.2]

f(x) = -2*x-3

h1(x) = (3-x) / 3
h2(x) = x -1

set style fill transparent solid 0.3 noborder

set yzeroaxis linetype 1 linecolor "black" linewidth 2

set object 1 polygon from 0, h1(0) to 0, h2(0) to 1.5, h2(1.5) to 1.5, h1(1.5) to 0, h1(0) \
    fillstyle transparent solid 0.3 fc "yellow"

plot '../data/state.dat' using 1:($2-$3) with linespoints title 'LP example' linewidth 2, \
     h1(x) with lines title "x + 3y = 3" linecolor "blue" linewidth 2, \
     h2(x) with lines title "x - y = 1" linecolor "red" linewidth 2, \
     f(x) + 1 with lines lt 2 linewidth 1 linecolor "gray" notitle, \
     f(x) + 2 with lines lt 2 linewidth 1 linecolor "gray" notitle, \
     f(x) + 3 with lines lt 2 linewidth 1 linecolor "gray" notitle, \
     f(x) + 4 with lines lt 2 linewidth 1 linecolor "gray" notitle, \
     f(x) + 5 with lines lt 2 linewidth 1 linecolor "gray" notitle, \
     f(x) + 6 with lines lt 2 linewidth 1 linecolor "gray" notitle, \
     f(x) + 7 with lines lt 2 linewidth 1 linecolor "gray" notitle

