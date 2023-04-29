#set heading(numbering: "1.1.a.")


#show heading: it => {
  smallcaps([#it])
}

#align(center, text(20pt)[
  #text(12pt, [*samansafn verkefna og svara*])\ _TÖL401G - Stýrikerfi_
])

#let question(body) = {
  rect(
    inset: 8pt, 
    width: 100%, 
    [#text(weight:"bold", style: "normal")[Verkefni: ] #body])
}

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  align(center)[
    #link("https://github.com/Sveppi")[Sverrir Sigfúrsson]
  ],
  align(center)[
    #link("")[Sigríður Birna]
  ],
  align(center)[
    #link("https://github.com/ofurtumi")[Þorvaldur Tumi]
  ],
  align(center)[
    #link("https://github.com/BjarniTS")[Bjarni Þór]
  ]
)

#outline(title: "Yfirlit")

= Umræða um stýrikerfi
#question([Ræðið hvort stýrikerfi séu nauðsynleg. Pælið til dæmis í tækjum sem keyra aðeins eitt forrit án nokkurs inntaks frá notanda. Er nauðsynlegt fyrir þessi tæki að hafa stýrikerfi?])

  Pínulitlar tölvur með jafnvel bara eitt forrit þurfa ekki endilega stýrikerfi.

  Þar sem það er bara eitt forrit að keyra þarf ekki að halda vera með minnistýringu, það er bara einn aðili að nota minnið þannig það þarf ekki að passa að taka það frá og gefa það til baka.

  Það þarf ekki að halda utan ferlavinnslu, _"process management"_, þar sem það er bara einn ferill í gangi á hverjum tíma

  Segjum að tilgangur þessarar litlu tölvu okkar sé að mæla rakastig í herbergi, það eina sem hún gerir er að senda út hvort rakastigið sé yfir ákveðnu marki. Hér þarf aldrei að skrifa gögn þannig það þarf ekki að halda utan um "mass storage".

  Í stuttu máli, þegar verið er að vinna á mjög láum level með kerfi sem eru vel hönnuð ætti ekki að þurfa stýrikerfi fyrir tölvur.

= Posix standardinn
== Hvað er Posix?
=== Hvaða stofnanir (fleiri en ein) sjá um skilgreiningu á POSIX staðalinum?

Stöðlunarhópar fyrir POSIX innihalda _Austin Group_, _ISO-hópinn_ og _The Open Group_, #link("https://pubs.opengroup.org/onlinepubs/9699919799/")[ sjá heimild ]

=== Hvað er nafn og númer núverandi POSIX staðals?
Nýjasti staðallinn er *POSIX.1-2017* líka þekktur sem *IEEE Std 1003.1-2017* og var gefinn út 2017. 

=== Um hvað fjallar POSIX í stuttu máli?
POSIX er samansafn af stöðlum til þess að auðvelda tengingu á milli stýrikerfa, þá sérstaklega stýrikerfa byggð ofan á unix.

== Um hvað fjalla eftirfarandi kaflar í POSIX staðalinum? 
=== Base Definitions
"Base Definitions" fjalla um almenn kerfi og "interface" sem eru þekkt í langflestum kerfum. Þetta eru meðal annars staðlar um reglulegar segðir, hausa í C tungumálinu og skilgreiningar á gagnagrunnum.

=== System Interfaces
"System Interfaces" fjallar um, eins og nafnið gefur til kynna, viðmót sem kerfi sem uppfylla POSIX staðalinn geta gert ráð fyrir. Hér er skilgreint hvernig á að setja fram föll inn í forritum ásamt "macros" og mörgu fleira.

=== Shell & Utilities
"Shell and Utilities" kaflinn fjallar um skipanair og nytjagögn sem forrit á POSIX kerfum geta nýtt sér. Hér er talað um hvernig á að stýra skipanalínu, finna hvar í skráarkerfi maður er og fleira.

== Finndu dæmi um...
=== Stýrikerfi sem uppfyllir POSIX staðalinn
Mac OS X 10.8 og seinni útgáfur af Mac OS eru POSIX vottuð

=== Stýrikerfi sem uppfyllir megnið af POSIX staðalinum
Flest linux stýrikerfi eru mestmegnis POSIX vottuð, mörg þeirra eru ábyggilega alveg POSIX vottuð en staðfesting á því er dýr og það stoppar flest distro í því að ná sér í vottun.

= Hypervisors
Í báðum verkefnum er verið að skoða _"VM hypervisor"_ sem sér um að keyra tvö stýrikerfi $"OS"_1$ og $"OS"_2$ innan tveggja virtual véla á kerfi með einn kjarna.
== 
#question([Verkraðari yfirstýrikerfisins _(scheduler, hypervisor)_ hefur gefið $"OS"_1$ 20ms af CPU tíma. Á meðan $"OS"_1$ er að keyra í sínum gefna tímaramma klárast biðtími $"OS"_2$ og það stýrikerfi lætur sinn CPU verkraða vita. Lýsið tveimur möguleikum fyrir yfirstýrikerfið til að takast á þessu.]) 

Ein lausn væri fyrirbyggjandi plönun _(preemptive scheduling)_. Hver hlutur fær að keyra í ákveðin tíma, og eftir það er tekinn í burtu og settur í röð. Þannig gæti yfirstýrikerfið truflað keyrslu á $"OS"_1$ og farið að keyra $"OS"_2$.

Önnur lausn væri að tímastýra kerfunum _(time-sharing)_. Þá leyfir yfirstýrikerfið $"OS"_1$ að keyra í 20ms, en minnkar tíma sem það fær í næsta tímaramma til að bæta upp fyrir tímann sem $"OS"_2$ missti.

== 
#question([Þegar verið er að vinna með sýndarvélar eru sýndarvélarnar ótengdar hvor annari. $"OS"_1$ keyrandi á vél $"VM"_1$ getur ekki nálgast skráarkerfi ytri vélarinnar né skránna á kerfi $"OS"_2$ keyrandi á $"VM"_2$. Lýsið mögulegri aðferð til að veita vélunum möguleika á að deila skrám])

Það er mögulegt fyrir fleiri en eina sýndarvél að deila skrárkerfis-staðsetningu _(file-system volume)_ sem gerir þeim kleyft að deila skrám.

