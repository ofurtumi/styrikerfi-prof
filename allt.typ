#set heading(numbering: "1.1.a.")



#show heading: it => {
  smallcaps([#it])
}

#show raw.where(block: true): block.with(
  width: 100%,
  fill: luma(230),
  inset: 8pt, // 100% bad
  radius: 4pt,
  breakable: false,
)


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

#outline(title: "Yfirlit", depth: 2)

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
== Tímastýring
#question([Verkraðari yfirstýrikerfisins _(scheduler, hypervisor)_ hefur gefið $"OS"_1$ 20ms af CPU tíma. Á meðan $"OS"_1$ er að keyra í sínum gefna tímaramma klárast biðtími $"OS"_2$ og það stýrikerfi lætur sinn CPU verkraða vita. Lýsið tveimur möguleikum fyrir yfirstýrikerfið til að takast á þessu.]) 

Ein lausn væri fyrirbyggjandi plönun _(preemptive scheduling)_. Hver hlutur fær að keyra í ákveðin tíma, og eftir það er tekinn í burtu og settur í röð. Þannig gæti yfirstýrikerfið truflað keyrslu á $"OS"_1$ og farið að keyra $"OS"_2$.

Önnur lausn væri að tímastýra kerfunum _(time-sharing)_. Þá leyfir yfirstýrikerfið $"OS"_1$ að keyra í 20ms, en minnkar tíma sem það fær í næsta tímaramma til að bæta upp fyrir tímann sem $"OS"_2$ missti.

== Sýndarvélar
#question([Þegar verið er að vinna með sýndarvélar eru sýndarvélarnar ótengdar hvor annari. $"OS"_1$ keyrandi á vél $"VM"_1$ getur ekki nálgast skráarkerfi ytri vélarinnar né skránna á kerfi $"OS"_2$ keyrandi á $"VM"_2$. Lýsið mögulegri aðferð til að veita vélunum möguleika á að deila skrám])

Það er mögulegt fyrir fleiri en eina sýndarvél að deila skrárkerfis-staðsetningu _(file-system volume)_ sem gerir þessum sýndarvélum kleyft að deila skrám. 

= Boot Process
#question([Lýsið skrefunum í uppstyllingu kerfisins _(boot process)_ alveg þangað til að innskráningar gluggi stýrikerfisins birtist. Leggið áherslu á hvað gerist þegar innra ræsiforritið _(bootstrap)_ hefur komið kjarna _(kernel)_ inn í RAM])

Við getum gert ráð fyrir því að búið sé að hlaða kernel inn í minni eftir skref tvö á bootloader ferlinu. Í hausnum á kernel myndinni er örlítill kóði sem setur upp lágmarks tengingu við vélbúnaðinn, þetta gerir vélinni kleift að uncompressa kernelinn og setja hann í high memory. 

Eftir að búið er að klára vinnslu á kernel, er skráarkerfið fest sem leyfir kernelinu að sjá og nálgast nauðsynlegar skrár. Eftir það er keyrt frumstyllingarforrit sem setur upp kerfiseiningar, net, skráarkerfi og þessháttar. Að lokum keyrir frumstylliforritið upp notendaviðmótið á samt fleiri kerfiseiningum. Þegar öll þessi skref eru klárað er process 1 keyrt upp.

= Scheduler
#question([Útfærðu scheduler aðferð sem tekst á eftirfarandi aðstæðum:
  - Timer interrupt - Aðferðin fær merki um að tímarammi hafi klárast
  - I/O syscall - Aðferð sem er að keyra biður um *I/O*
  - I/O interrupt - Tæki lætur vita að *I/O* hafi klárast])

```java
// kóðinn sem var gefinn
schedulerUnfinished() {
  if (called by timer interrupt) { 
    // Time slice of current process expired 
   } else if (called by I/O system call) { 
    // I/O request by current process 
  } else if (called by I/O interrupt) { 
    // I/O of process ioCompleted completed 
  }

  // Further code outside if statements (if required)
}

// kóðinn sem var skilað
schedulerFinished() {
    if (called by timer interrupt) { // Time slice of current process expired  
        addToTail(running, ready);
    } else if (called by I/O system call) { // I/O request by current process 
        addToTail(running, waiting);
    } else if (called by I/O interrupt) { // I/O of process ioCompleted completed 
        addToTail(running, waiting);
        findAndRemove(ioCompleted, waiting);
    }

    // Further code outside if statements (if required)
    interruptOn()
    if (ready == null) {
        sleep()
    } else {
        running = removeFromHead(ready);
        switchTo(running)
    }
}
```
eftirfarandi aðferðir og hlutir voru gefnir:
- `addToTail(pcb, queue)`: Append pcb to the tail of the queue queue.
- `removeFromHead(queue)`: Remove the element at the head of the queue queue and return this element. If the queue is empty, NULL is returned
- `findAndRemove(pid, queue)`: Find and return PCB entry with PId pid in the queue queue. Removes that PCB entry from the queue.
- `interruptsOn()`: Enables all interrupts again. 
- `sleep()`: Puts the CPU into sleep mode, only an interrupt will wake up the CPU.
- `switchTo(pcb)`: Restarts the timer of the time slice expiration interrupt and switches to the
context stored in pcb.

= Stýrikerfis apar (APIs)
== Windows API
#question([Finnið hvaða system calls Windows apinn bíður upp á til að búa til og eyða prósessum og lýsið stuttlega nafni, inntaki og högun aðferðanna])

Það eru þrjú *system calls* til að búa til *process* í windows apanum.
+ `CreateProcessA()`
+ `CreateProcessAsUserA()`
+ `CreateProcessAsUserW()`
+ `CreateProcessW()`

Allar þessar aðferðir búa til *process* helsti munurinn á milli þeirra eru réttindin sem veitt eru til þess sem kallar á þær.  

Parametrarnir sem þær taka eru eftirfarandi 
- `lpApplicationName`: nafn forritsins sem kallar á fallið *(getur verið `Null`)*
- `lpCommandLine`: skipunin sem á að keyra
- `lpProcessAttributes`: bendir sem segir til um öryggisreglur fyrir processin
- `lpThreadAttributes`: bendir sem segir til um öryggisreglur fyrir aðalþráð processins
- `bInheritHandles`: boolean, segir til um hvort nýji process eigi að erfa frá process sem kallaði á sig
- `dwCreationFlags`: auka flögg sem stilla uppsetninguna
- `lpEnvironment`: bendir á svæðið þar sem processinn fær að lifa, ef `Null` lifir á svæði kallfallsins
- `lpCurrentDirectory`: slóð að working directory
- `lpStartupInfo`: bendir á upplýsingar um kerfið, monitora ofl.
- `lpProcessInformation`: bendir á svæði sem fær upplýsingar um nýja processinn

Það eru tvær aðferðir til að fjarlægja process:
+ `TerminateProcess()`
+ `ExitProcess()`

báðar aðferðirnar hafa parameterinn `uExitCode` sem er einfaldlega exit kóði processins þegar hann er fjarlægður  
`TerminateProcess()` hefur líka `hProcess` sem er handle fyrir þann process sem á að drepa

== Posix API
#question([Hvaða tvær skipanir innan POSIX kerfa eru sambærilegar skipunum úr Windows apanum til þess að búa til nýjan process])

Í *POSIX* stöðluðu kerfi eru skipanirnar til þess að búa til nýtt process í sameiningu, `fork()` og svo `exec()`. Fork býr til copy af process og exec keyrir hann af stað.


= Connection less sockets
#question([Útbúið lausn fyrir producer / consumer vandamálið í java með _zero capacity buffer_ þ.e. buffer sem ekkert getur geymt. Annað forritið starfar sem producer og sendir gögn, vaxandi heiltölur, á consumer sem tekur við þeim. Hitt forritið skal starfa sem consumer, það tekur við gögnum frá producer og prentar þau út.])

#grid(columns: (1fr, 1fr),
  gutter: 6pt,
text(
  size: 7pt,
  [**
  ```java
import java.net.*;
import java.io.*;

public class Producer {
  public static void main(String args[]) {
    DatagramSocket aSocket = null;
    try {
      aSocket = new DatagramSocket(6789); 
      byte[] buffer = new byte[1000];
      byte[] out = new byte[1000];
      int item = 0;

      while (true) {
        item++;
        DatagramPacket request = 
          new DatagramPacket(
            buffer, 
            buffer.length
          );
        aSocket.receive(request);
        out = Integer.toString(item).getBytes();
        DatagramPacket reply = 
          new DatagramPacket(
            out, 
            out.length, 
            request.getAddress(), 
            request.getPort()
          );
        aSocket.send(reply);
        System.out.println("item --> " + item);
      }
    } catch (SocketException e) {
      System.out.println("Socket: " + e.getMessage());
    } catch (IOException e) {
      System.out.println("IO: " + e.getMessage());
    } finally {
    if (aSocket != null) aSocket.close();
    }
  }
}```]),
text(
  size: 7pt,
  [
```java
import java.io.*;
import java.net.*;

public class Consumer {
  public static void main(String args[]) {  
    // args[0]: message contents  
    // args[1]: destination hostname
    DatagramSocket aSocket = null;
      try {
        while (true) {
          aSocket = new DatagramSocket();
          byte[] message = args[0].getBytes();
          InetAddress aHost = 
            InetAddress.getByName(args[1]);
          int serverPort = 6789; // fyrirfram ákveðið port
          DatagramPacket request = 
            new DatagramPacket(
              message, 
              message.length, 
              aHost, 
              serverPort
            );
          aSocket.send(request);
          byte[] buffer = new byte[1000];
          DatagramPacket reply = 
            new DatagramPacket(buffer, buffer.length);
          aSocket.receive(reply);
          System.out.println(
            "Reply: " + new String(reply.getData())
          );
        }
      } catch (SocketException e) {
        System.out.println("Socket: " + e.getMessage());
      } catch (IOException e) {
        System.out.println("IO: " + e.getMessage());
      } finally {
      if (aSocket != null) aSocket.close();
    }
  }
}
```])
)

= Connection oriented sockets
#question([Útfærið Java server sem tekur við streng en túlkar hann sem heiltölu $n$ og framkvæmir síðan endurkvæmt Fibonacci reiknirit til að finna n-tu Fibonacci töluna. Breytið síðan útfærslunni ykkar til að nota marga þræði _(multithreaded)_.]) 

#grid(
  columns: (1fr, 1fr),
  gutter: 6pt,
  text(size: 6pt, 
    [```java
import java.net.*;
import java.io.*;

public class ConnectionOrientedClient {
  public static void main(String args[]) {
    // args[0]: message contents, args[1]: destination hostname
    Socket aSocket = null;
    try {
      int serverPort = 7896;
      aSocket = new Socket(args[1], serverPort);
      DataInputStream in = 
        new DataInputStream(aSocket.getInputStream());
      DataOutputStream out = 
        new DataOutputStream(aSocket.getOutputStream());
      out.writeUTF(args[0]); // UTF is a string encoding
      String data = in.readUTF(); 
      // read a line of data from the stream
      System.out.println("Received: " + data);
    } catch (UnknownHostException e) { 
      System.out.println("Socket:" + e.getMessage());
    } catch (EOFException e) { 
      System.out.println("EOF:" + e.getMessage());
    } catch (IOException e) { 
      System.out.println("readline:" + e.getMessage());
    } finally {
      if (aSocket != null)
      try { aSocket.close(); } 
      catch (IOException e) { 
        System.out.println("close:" + e.getMessage());
      }
    }
  }
}```]),
text(size: 6pt, [```java
import java.net.*;
import java.io.*;

public class ConnectionOrientedServer {
  public static void main(String args[]) {
  try {
    int serverPort = 7896; // the server port
    ServerSocket listenSocket = new ServerSocket(serverPort);
    while (true) {
      Socket clientSocket = listenSocket.accept();
      Connection c = new Connection(clientSocket); // Handle request
      c.start();
    }
  } catch (IOException e) {
    System.out.println(
      "Listen socket:" + e.getMessage());
    }
  }
} 
```]))
