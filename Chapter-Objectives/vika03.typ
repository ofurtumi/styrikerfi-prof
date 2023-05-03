#set heading(numbering: "1.1.a.")

#show raw.where(block: true): it => {
  block(
    width: 100%,
    fill: luma(230),
    inset: 8pt, // 100% bad>
    radius: 4pt,
    breakable: false,
    text(size: 7pt, [#it])
  )
}


#align(center, text(20pt)[
  #text(12pt, [*Vika 3*])\ _TÖL401G - Stýrikerfi_
])


= Describe the role and responsibilities of an operating system (OS).
    The OS is the most important program that runs on a computer. Every general-purpose computer must have an OS to run other programs. Operating systems perform basic tasks, such as recognizing input from the keyboard, sending output to the display screen, keeping track of files and directories on the disk, and controlling peripheral devices such as disk drives and printers. The operating system acts as an intermediary between a user of a computer (and the used application programs) and the computer hardware. It also provides environment for other software to execute correctly.

= Describe the general organization of a computer system and the role of interrupts.

    The computer system can be divided into four components: 
    - the hardware, 
    - the operating system, 
    - the application programs, 
    - the users. 

    == The hardware
    - CPU, 
    - memory,  
    - I/O devices

    provides the basic computing resources for the system.

    == The operating system
    Controls the hardware and coordinates its use among the various application programs for the various users. The operating system acts as a resource manager.

    == The application programs
    - such as word processors, 
    - spreadsheets, 
    - compilers, 
    - Web browsers
    
    == The user
    Communicates with the system through the user interface, such as the command-line interpreter or graphical user interface (GUI).

    == Interupts
    Interrupt service routines (ISR) preserves the state of the CPU by saving regesters and then calls the appropriate OS routine to handle the interrupt. When the OS routine completes, control is returned to the ISR, which restores the saved registers and returns control to the interrupted program.

= Describe the components in a modern multiprocessor computer system.
    == A multiprocessor system consists of 
    - two or more CPUs that share a common physical memory. 

    == Multiprocessor systems are also known as 
    - parallel systems, 
    - tightly coupled systems, 
    - and shared-memory systems. 

    == Multiprocessor systems are more complex than uniprocessor systems because of 
    - the need to manage concurrent access to the shared memory. 
    
    ==  Multiprocessor systems are more economical because
    - they can share resources. 
    
    == Multiprocessor systems can be categorized according to the number of CPUs. 
    - A symmetric multiprocessing (SMP) system has two or more similar processors running the same OS and performing the same tasks. 
    - An asymmetric multiprocessing (AMP) system has one master processor and one or more slave processors. 

        - The master processor schedules and allocates work to the slave processors.

    - A clustered system consists of two or more individual systems joined together. The individual systems are independent but work together as a single system.

        - A cluster can be configured as a load-balancing cluster or a high-availability cluster.


= Illustrate the transition from user mode to kernel mode.
    - The transition from user mode to kernel mode occurs when a user program requests a service from the OS, such as a request to read data from a file. The system must ensure that the request is valid and that the user program has the right to access the file. The system then executes the request on behalf of the user program. 
    - The transition from user mode to kernel mode is usually done via a system call, which is a request to the OS to allow a user program to access a resource. The system call is usually initiated by a user program via a software interrupt. The system call is handled by a dispatcher, which is a routine within the OS that examines the request and determines how to execute it. 
    - The dispatcher then invokes the appropriate OS routine to perform the request. When the OS routine completes, control is returned to the dispatcher, which returns control to the user program.

= Discuss how operating systems are used in various computing environments.
    Operating systems are used in a variety of computing environments, including:
    - desktop systems, 
    - multiprocessor systems, 
    - distributed systems, 
    - cluster systems, 
    - real-time systems, 
    - and handheld systems. 
    
    --> Desktop systems are single-user systems that work with a single processor.

    --> Multiprocessor systems are used to increase throughput and reliability. 
    
    --> Distributed systems are used to provide users with access to remote resources, such as printers, files, and databases. Cluster systems are used to provide high availability and load balancing. 
    
    --> Real-time systems are used as control devices in a dedicated application. 
    
    --> Handheld systems are used to provide computing resources in a small, portable package.


= Provide examples of free and open-source operating systems.
    Examples of free and open-source operating systems include 
    - Linux, 
    - FreeBSD, 
    - NetBSD,  
    - OpenBSD. 
    Linux is a free and open-source OS that is based on UNIX and is available for a wide range of computing platforms. Linux is available in a number of distributions, such as Red Hat, Fedora, Ubuntu, and Debian. 
    
    FreeBSD, NetBSD, and OpenBSD are free and open-source OSs that are based on UNIX and are available for a wide range of computing platforms. 
    
    FreeBSD is a general-purpose OS that is used in a variety of applications. 
    
    NetBSD is a general-purpose OS that is used in a variety of applications. 
    
    OpenBSD is a general-purpose OS that is used in a variety of applications. OpenBSD is known for its security features.