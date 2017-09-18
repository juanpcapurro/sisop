
kern0:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 66                	in     $0x66,%al
  10000d:	90                   	nop
  10000e:	66 90                	xchg   %ax,%ax

00100010 <comienzo>:
  100010:	83 ec 0c             	sub    $0xc,%esp
  100013:	c7 04 24 2a 00 00 00 	movl   $0x2a,(%esp)
  10001a:	b9 b1 00 10 00       	mov    $0x1000b1,%ecx
  10001f:	ba 01 00 00 00       	mov    $0x1,%edx
  100024:	e8 27 00 00 00       	call   100050 <vga_write>
  100029:	c7 04 24 e0 00 00 00 	movl   $0xe0,(%esp)
  100030:	b9 b4 00 10 00       	mov    $0x1000b4,%ecx
  100035:	ba 02 00 00 00       	mov    $0x2,%edx
  10003a:	e8 11 00 00 00       	call   100050 <vga_write>
  10003f:	90                   	nop
  100040:	f4                   	hlt    
  100041:	eb fd                	jmp    100040 <comienzo+0x30>
  100043:	66 66 66 66 2e 0f 1f 	data16 data16 data16 nopw %cs:0x0(%eax,%eax,1)
  10004a:	84 00 00 00 00 00 

00100050 <vga_write>:
  100050:	84 d2                	test   %dl,%dl
  100052:	79 06                	jns    10005a <vga_write+0xa>
  100054:	b0 19                	mov    $0x19,%al
  100056:	28 d0                	sub    %dl,%al
  100058:	88 c2                	mov    %al,%dl
  10005a:	53                   	push   %ebx
  10005b:	56                   	push   %esi
  10005c:	8a 44 24 0c          	mov    0xc(%esp),%al
  100060:	0f be d2             	movsbl %dl,%edx
  100063:	8d 14 92             	lea    (%edx,%edx,4),%edx
  100066:	c1 e2 05             	shl    $0x5,%edx
  100069:	81 c2 01 80 0b 00    	add    $0xb8001,%edx
  10006f:	31 f6                	xor    %esi,%esi
  100071:	31 db                	xor    %ebx,%ebx
  100073:	66 66 66 66 2e 0f 1f 	data16 data16 data16 nopw %cs:0x0(%eax,%eax,1)
  10007a:	84 00 00 00 00 00 
  100080:	80 3c 31 00          	cmpb   $0x0,(%ecx,%esi,1)
  100084:	b4 01                	mov    $0x1,%ah
  100086:	74 02                	je     10008a <vga_write+0x3a>
  100088:	88 dc                	mov    %bl,%ah
  10008a:	88 04 72             	mov    %al,(%edx,%esi,2)
  10008d:	f6 c4 01             	test   $0x1,%ah
  100090:	75 0e                	jne    1000a0 <vga_write+0x50>
  100092:	8a 1c 31             	mov    (%ecx,%esi,1),%bl
  100095:	eb 0b                	jmp    1000a2 <vga_write+0x52>
  100097:	66 0f 1f 84 00 00 00 	nopw   0x0(%eax,%eax,1)
  10009e:	00 00 
  1000a0:	31 db                	xor    %ebx,%ebx
  1000a2:	88 5c 72 ff          	mov    %bl,-0x1(%edx,%esi,2)
  1000a6:	46                   	inc    %esi
  1000a7:	83 fe 50             	cmp    $0x50,%esi
  1000aa:	88 e3                	mov    %ah,%bl
  1000ac:	75 d2                	jne    100080 <vga_write+0x30>
  1000ae:	5e                   	pop    %esi
  1000af:	5b                   	pop    %ebx
  1000b0:	c3                   	ret    
