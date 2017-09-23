
kern1:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4                   	.byte 0xe4

0010000c <_start>:
  10000c:	bd 00 00 00 00       	mov    $0x0,%ebp
  100011:	bc 00 10 10 00       	mov    $0x101000,%esp
  100016:	55                   	push   %ebp
  100017:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
  10001c:	0f 45 1d 00 30 10 00 	cmovne 0x103000,%ebx
  100023:	53                   	push   %ebx
  100024:	e8 e7 02 00 00       	call   100310 <kmain>

00100029 <halt>:
  100029:	f4                   	hlt    
  10002a:	eb fd                	jmp    100029 <halt>
  10002c:	66 90                	xchg   %ax,%ax
  10002e:	66 90                	xchg   %ax,%ax

00100030 <vga_write>:
  100030:	55                   	push   %ebp
  100031:	89 e5                	mov    %esp,%ebp
  100033:	83 ec 14             	sub    $0x14,%esp
  100036:	8a 45 10             	mov    0x10(%ebp),%al
  100039:	8a 4d 0c             	mov    0xc(%ebp),%cl
  10003c:	8b 55 08             	mov    0x8(%ebp),%edx
  10003f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  100042:	88 4d fb             	mov    %cl,-0x5(%ebp)
  100045:	88 45 fa             	mov    %al,-0x6(%ebp)
  100048:	0f be 55 fb          	movsbl -0x5(%ebp),%edx
  10004c:	83 fa 00             	cmp    $0x0,%edx
  10004f:	0f 8d 10 00 00 00    	jge    100065 <vga_write+0x35>
  100055:	b8 19 00 00 00       	mov    $0x19,%eax
  10005a:	0f be 4d fb          	movsbl -0x5(%ebp),%ecx
  10005e:	29 c8                	sub    %ecx,%eax
  100060:	88 c2                	mov    %al,%dl
  100062:	88 55 fb             	mov    %dl,-0x5(%ebp)
  100065:	a1 fc 0a 10 00       	mov    0x100afc,%eax
  10006a:	0f be 4d fb          	movsbl -0x5(%ebp),%ecx
  10006e:	c1 e1 01             	shl    $0x1,%ecx
  100071:	6b c9 50             	imul   $0x50,%ecx,%ecx
  100074:	01 c8                	add    %ecx,%eax
  100076:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100079:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
  10007d:	c6 45 f2 00          	movb   $0x0,-0xe(%ebp)
  100081:	0f b6 45 f2          	movzbl -0xe(%ebp),%eax
  100085:	83 f8 50             	cmp    $0x50,%eax
  100088:	0f 8d 7b 00 00 00    	jge    100109 <vga_write+0xd9>
  10008e:	0f b6 45 f2          	movzbl -0xe(%ebp),%eax
  100092:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  100095:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100099:	0f 85 04 00 00 00    	jne    1000a3 <vga_write+0x73>
  10009f:	c6 45 f3 01          	movb   $0x1,-0xd(%ebp)
  1000a3:	0f b6 45 f2          	movzbl -0xe(%ebp),%eax
  1000a7:	c1 e0 01             	shl    $0x1,%eax
  1000aa:	83 c0 01             	add    $0x1,%eax
  1000ad:	88 c1                	mov    %al,%cl
  1000af:	88 4d f1             	mov    %cl,-0xf(%ebp)
  1000b2:	0f b6 45 f2          	movzbl -0xe(%ebp),%eax
  1000b6:	c1 e0 01             	shl    $0x1,%eax
  1000b9:	88 c1                	mov    %al,%cl
  1000bb:	88 4d f0             	mov    %cl,-0x10(%ebp)
  1000be:	8a 4d fa             	mov    -0x6(%ebp),%cl
  1000c1:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1000c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1000c8:	88 0c 02             	mov    %cl,(%edx,%eax,1)
  1000cb:	f6 45 f3 01          	testb  $0x1,-0xd(%ebp)
  1000cf:	0f 84 0a 00 00 00    	je     1000df <vga_write+0xaf>
  1000d5:	31 c0                	xor    %eax,%eax
  1000d7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1000da:	e9 0e 00 00 00       	jmp    1000ed <vga_write+0xbd>
  1000df:	0f b6 45 f2          	movzbl -0xe(%ebp),%eax
  1000e3:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  1000e6:	0f be 04 01          	movsbl (%ecx,%eax,1),%eax
  1000ea:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1000ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1000f0:	88 c1                	mov    %al,%cl
  1000f2:	0f b6 45 f0          	movzbl -0x10(%ebp),%eax
  1000f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1000f9:	88 0c 02             	mov    %cl,(%edx,%eax,1)
  1000fc:	8a 45 f2             	mov    -0xe(%ebp),%al
  1000ff:	04 01                	add    $0x1,%al
  100101:	88 45 f2             	mov    %al,-0xe(%ebp)
  100104:	e9 78 ff ff ff       	jmp    100081 <vga_write+0x51>
  100109:	83 c4 14             	add    $0x14,%esp
  10010c:	5d                   	pop    %ebp
  10010d:	c3                   	ret    
  10010e:	66 90                	xchg   %ax,%ax

00100110 <console_out>:
  100110:	55                   	push   %ebp
  100111:	89 e5                	mov    %esp,%ebp
  100113:	53                   	push   %ebx
  100114:	83 ec 14             	sub    $0x14,%esp
  100117:	8b 45 08             	mov    0x8(%ebp),%eax
  10011a:	b9 02 00 00 00       	mov    $0x2,%ecx
  10011f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100122:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100125:	8b 15 04 30 10 00    	mov    0x103004,%edx
  10012b:	88 d3                	mov    %dl,%bl
  10012d:	89 04 24             	mov    %eax,(%esp)
  100130:	0f be c3             	movsbl %bl,%eax
  100133:	89 44 24 04          	mov    %eax,0x4(%esp)
  100137:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
  10013e:	00 
  10013f:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  100142:	e8 e9 fe ff ff       	call   100030 <vga_write>
  100147:	a1 04 30 10 00       	mov    0x103004,%eax
  10014c:	83 c0 01             	add    $0x1,%eax
  10014f:	a3 04 30 10 00       	mov    %eax,0x103004
  100154:	83 3d 04 30 10 00 19 	cmpl   $0x19,0x103004
  10015b:	0f 8c 0a 00 00 00    	jl     10016b <console_out+0x5b>
  100161:	c7 05 04 30 10 00 00 	movl   $0x0,0x103004
  100168:	00 00 00 
  10016b:	83 c4 14             	add    $0x14,%esp
  10016e:	5b                   	pop    %ebx
  10016f:	5d                   	pop    %ebp
  100170:	c3                   	ret    
  100171:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 nopw %cs:0x0(%eax,%eax,1)
  100178:	0f 1f 84 00 00 00 00 
  10017f:	00 

00100180 <fmt_int>:
  100180:	55                   	push   %ebp
  100181:	89 e5                	mov    %esp,%ebp
  100183:	53                   	push   %ebx
  100184:	56                   	push   %esi
  100185:	83 ec 40             	sub    $0x40,%esp
  100188:	8b 45 10             	mov    0x10(%ebp),%eax
  10018b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  10018e:	8b 55 08             	mov    0x8(%ebp),%edx
  100191:	89 55 f0             	mov    %edx,-0x10(%ebp)
  100194:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  100197:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10019a:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%ebp)
  1001a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1001a4:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1001a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1001aa:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  1001ad:	89 e2                	mov    %esp,%edx
  1001af:	89 4a 04             	mov    %ecx,0x4(%edx)
  1001b2:	c7 02 0a 00 00 00    	movl   $0xa,(%edx)
  1001b8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  1001bb:	e8 d0 00 00 00       	call   100290 <power>
  1001c0:	31 c9                	xor    %ecx,%ecx
  1001c2:	8b 75 d4             	mov    -0x2c(%ebp),%esi
  1001c5:	29 c6                	sub    %eax,%esi
  1001c7:	19 d1                	sbb    %edx,%ecx
  1001c9:	89 75 d0             	mov    %esi,-0x30(%ebp)
  1001cc:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  1001cf:	0f 82 0e 00 00 00    	jb     1001e3 <fmt_int+0x63>
  1001d5:	e9 00 00 00 00       	jmp    1001da <fmt_int+0x5a>
  1001da:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
  1001de:	e9 94 00 00 00       	jmp    100277 <fmt_int+0xf7>
  1001e3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  1001ea:	b8 0a 00 00 00       	mov    $0xa,%eax
  1001ef:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  1001f2:	89 45 c8             	mov    %eax,-0x38(%ebp)
  1001f5:	89 c8                	mov    %ecx,%eax
  1001f7:	31 d2                	xor    %edx,%edx
  1001f9:	8b 4d c8             	mov    -0x38(%ebp),%ecx
  1001fc:	f7 f1                	div    %ecx
  1001fe:	89 45 e0             	mov    %eax,-0x20(%ebp)
  100201:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100204:	83 c0 01             	add    $0x1,%eax
  100207:	89 45 dc             	mov    %eax,-0x24(%ebp)
  10020a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  10020e:	0f 87 d6 ff ff ff    	ja     1001ea <fmt_int+0x6a>
  100214:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100217:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10021a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10021d:	83 e8 01             	sub    $0x1,%eax
  100220:	89 45 d8             	mov    %eax,-0x28(%ebp)
  100223:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  100227:	0f 8c 3c 00 00 00    	jl     100269 <fmt_int+0xe9>
  10022d:	b8 0a 00 00 00       	mov    $0xa,%eax
  100232:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  100235:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  100238:	89 c8                	mov    %ecx,%eax
  10023a:	31 d2                	xor    %edx,%edx
  10023c:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  10023f:	f7 f1                	div    %ecx
  100241:	83 c2 30             	add    $0x30,%edx
  100244:	88 d3                	mov    %dl,%bl
  100246:	8b 55 d8             	mov    -0x28(%ebp),%edx
  100249:	8b 75 ec             	mov    -0x14(%ebp),%esi
  10024c:	88 1c 16             	mov    %bl,(%esi,%edx,1)
  10024f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100252:	89 d0                	mov    %edx,%eax
  100254:	31 d2                	xor    %edx,%edx
  100256:	f7 f1                	div    %ecx
  100258:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10025b:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10025e:	83 c0 ff             	add    $0xffffffff,%eax
  100261:	89 45 d8             	mov    %eax,-0x28(%ebp)
  100264:	e9 ba ff ff ff       	jmp    100223 <fmt_int+0xa3>
  100269:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10026c:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  10026f:	c6 04 01 00          	movb   $0x0,(%ecx,%eax,1)
  100273:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
  100277:	8a 45 f7             	mov    -0x9(%ebp),%al
  10027a:	24 01                	and    $0x1,%al
  10027c:	0f b6 c0             	movzbl %al,%eax
  10027f:	83 c4 40             	add    $0x40,%esp
  100282:	5e                   	pop    %esi
  100283:	5b                   	pop    %ebx
  100284:	5d                   	pop    %ebp
  100285:	c3                   	ret    
  100286:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%eax,%eax,1)
  10028d:	00 00 00 

00100290 <power>:
  100290:	55                   	push   %ebp
  100291:	89 e5                	mov    %esp,%ebp
  100293:	56                   	push   %esi
  100294:	83 ec 24             	sub    $0x24,%esp
  100297:	8b 45 0c             	mov    0xc(%ebp),%eax
  10029a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  10029d:	89 4d f8             	mov    %ecx,-0x8(%ebp)
  1002a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1002a3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  1002aa:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
  1002b1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  1002b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1002bb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  1002be:	0f 83 32 00 00 00    	jae    1002f6 <power+0x66>
  1002c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1002c7:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  1002ca:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1002cd:	0f af d0             	imul   %eax,%edx
  1002d0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1002d3:	89 c8                	mov    %ecx,%eax
  1002d5:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  1002d8:	89 55 dc             	mov    %edx,-0x24(%ebp)
  1002db:	f7 e1                	mul    %ecx
  1002dd:	8b 75 dc             	mov    -0x24(%ebp),%esi
  1002e0:	01 f2                	add    %esi,%edx
  1002e2:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1002e5:	89 55 ec             	mov    %edx,-0x14(%ebp)
  1002e8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1002eb:	83 c0 01             	add    $0x1,%eax
  1002ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1002f1:	e9 c2 ff ff ff       	jmp    1002b8 <power+0x28>
  1002f6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1002f9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1002fc:	83 c4 24             	add    $0x24,%esp
  1002ff:	5e                   	pop    %esi
  100300:	5d                   	pop    %ebp
  100301:	c3                   	ret    
  100302:	66 90                	xchg   %ax,%ax
  100304:	66 90                	xchg   %ax,%ax
  100306:	66 90                	xchg   %ax,%ax
  100308:	66 90                	xchg   %ax,%ax
  10030a:	66 90                	xchg   %ax,%ax
  10030c:	66 90                	xchg   %ax,%ax
  10030e:	66 90                	xchg   %ax,%ax

00100310 <kmain>:
  100310:	55                   	push   %ebp
  100311:	89 e5                	mov    %esp,%ebp
  100313:	53                   	push   %ebx
  100314:	57                   	push   %edi
  100315:	56                   	push   %esi
  100316:	81 ec 7c 02 00 00    	sub    $0x27c,%esp
  10031c:	8b 45 08             	mov    0x8(%ebp),%eax
  10031f:	8d 0d 00 0b 10 00    	lea    0x100b00,%ecx
  100325:	89 45 f0             	mov    %eax,-0x10(%ebp)
  100328:	89 0c 24             	mov    %ecx,(%esp)
  10032b:	e8 e0 fd ff ff       	call   100110 <console_out>
  100330:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100334:	0f 85 13 00 00 00    	jne    10034d <kmain+0x3d>
  10033a:	8d 05 1b 0b 10 00    	lea    0x100b1b,%eax
  100340:	89 04 24             	mov    %eax,(%esp)
  100343:	e8 c8 fd ff ff       	call   100110 <console_out>
  100348:	e9 96 00 00 00       	jmp    1003e3 <kmain+0xd3>
  10034d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100350:	8b 00                	mov    (%eax),%eax
  100352:	83 e0 04             	and    $0x4,%eax
  100355:	83 f8 00             	cmp    $0x0,%eax
  100358:	0f 84 72 00 00 00    	je     1003d0 <kmain+0xc0>
  10035e:	b8 00 01 00 00       	mov    $0x100,%eax
  100363:	8d 8d ec fe ff ff    	lea    -0x114(%ebp),%ecx
  100369:	8d 15 73 0b 10 00    	lea    0x100b73,%edx
  10036f:	8b 75 f0             	mov    -0x10(%ebp),%esi
  100372:	8b 76 10             	mov    0x10(%esi),%esi
  100375:	89 75 ec             	mov    %esi,-0x14(%ebp)
  100378:	89 ce                	mov    %ecx,%esi
  10037a:	89 34 24             	mov    %esi,(%esp)
  10037d:	89 54 24 04          	mov    %edx,0x4(%esp)
  100381:	c7 44 24 08 00 01 00 	movl   $0x100,0x8(%esp)
  100388:	00 
  100389:	89 85 d0 fd ff ff    	mov    %eax,-0x230(%ebp)
  10038f:	89 8d cc fd ff ff    	mov    %ecx,-0x234(%ebp)
  100395:	e8 19 02 00 00       	call   1005b3 <memcpy>
  10039a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10039d:	8b 8d cc fd ff ff    	mov    -0x234(%ebp),%ecx
  1003a3:	89 0c 24             	mov    %ecx,(%esp)
  1003a6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1003aa:	c7 44 24 08 00 01 00 	movl   $0x100,0x8(%esp)
  1003b1:	00 
  1003b2:	e8 ca 06 00 00       	call   100a81 <strlcat>
  1003b7:	8d 8d ec fe ff ff    	lea    -0x114(%ebp),%ecx
  1003bd:	89 0c 24             	mov    %ecx,(%esp)
  1003c0:	89 85 c8 fd ff ff    	mov    %eax,-0x238(%ebp)
  1003c6:	e8 45 fd ff ff       	call   100110 <console_out>
  1003cb:	e9 0e 00 00 00       	jmp    1003de <kmain+0xce>
  1003d0:	8d 05 38 0b 10 00    	lea    0x100b38,%eax
  1003d6:	89 04 24             	mov    %eax,(%esp)
  1003d9:	e8 32 fd ff ff       	call   100110 <console_out>
  1003de:	e9 00 00 00 00       	jmp    1003e3 <kmain+0xd3>
  1003e3:	b8 10 00 00 00       	mov    $0x10,%eax
  1003e8:	8d 8d d4 fd ff ff    	lea    -0x22c(%ebp),%ecx
  1003ee:	8d 15 73 0c 10 00    	lea    0x100c73,%edx
  1003f4:	be 00 01 00 00       	mov    $0x100,%esi
  1003f9:	8d bd e4 fd ff ff    	lea    -0x21c(%ebp),%edi
  1003ff:	8b 5d f0             	mov    -0x10(%ebp),%ebx
  100402:	8b 5b 04             	mov    0x4(%ebx),%ebx
  100405:	89 9d e8 fe ff ff    	mov    %ebx,-0x118(%ebp)
  10040b:	8b 5d f0             	mov    -0x10(%ebp),%ebx
  10040e:	8b 5b 08             	mov    0x8(%ebx),%ebx
  100411:	c1 eb 0a             	shr    $0xa,%ebx
  100414:	89 9d e4 fe ff ff    	mov    %ebx,-0x11c(%ebp)
  10041a:	89 3c 24             	mov    %edi,(%esp)
  10041d:	89 54 24 04          	mov    %edx,0x4(%esp)
  100421:	c7 44 24 08 00 01 00 	movl   $0x100,0x8(%esp)
  100428:	00 
  100429:	89 85 c4 fd ff ff    	mov    %eax,-0x23c(%ebp)
  10042f:	89 8d c0 fd ff ff    	mov    %ecx,-0x240(%ebp)
  100435:	89 b5 bc fd ff ff    	mov    %esi,-0x244(%ebp)
  10043b:	e8 73 01 00 00       	call   1005b3 <memcpy>
  100440:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  100446:	89 04 24             	mov    %eax,(%esp)
  100449:	8b 85 c0 fd ff ff    	mov    -0x240(%ebp),%eax
  10044f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100453:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  10045a:	00 
  10045b:	e8 20 fd ff ff       	call   100180 <fmt_int>
  100460:	b9 00 01 00 00       	mov    $0x100,%ecx
  100465:	8d 95 d4 fd ff ff    	lea    -0x22c(%ebp),%edx
  10046b:	8d b5 e4 fd ff ff    	lea    -0x21c(%ebp),%esi
  100471:	89 34 24             	mov    %esi,(%esp)
  100474:	89 54 24 04          	mov    %edx,0x4(%esp)
  100478:	c7 44 24 08 00 01 00 	movl   $0x100,0x8(%esp)
  10047f:	00 
  100480:	88 85 bb fd ff ff    	mov    %al,-0x245(%ebp)
  100486:	89 8d b4 fd ff ff    	mov    %ecx,-0x24c(%ebp)
  10048c:	e8 f0 05 00 00       	call   100a81 <strlcat>
  100491:	8d 0d 5b 0b 10 00    	lea    0x100b5b,%ecx
  100497:	ba 00 01 00 00       	mov    $0x100,%edx
  10049c:	8d b5 e4 fd ff ff    	lea    -0x21c(%ebp),%esi
  1004a2:	89 34 24             	mov    %esi,(%esp)
  1004a5:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  1004a9:	c7 44 24 08 00 01 00 	movl   $0x100,0x8(%esp)
  1004b0:	00 
  1004b1:	89 85 b0 fd ff ff    	mov    %eax,-0x250(%ebp)
  1004b7:	89 95 ac fd ff ff    	mov    %edx,-0x254(%ebp)
  1004bd:	e8 bf 05 00 00       	call   100a81 <strlcat>
  1004c2:	8d 8d e4 fd ff ff    	lea    -0x21c(%ebp),%ecx
  1004c8:	89 0c 24             	mov    %ecx,(%esp)
  1004cb:	89 85 a8 fd ff ff    	mov    %eax,-0x258(%ebp)
  1004d1:	e8 3a fc ff ff       	call   100110 <console_out>
  1004d6:	8d 05 60 0b 10 00    	lea    0x100b60,%eax
  1004dc:	b9 00 01 00 00       	mov    $0x100,%ecx
  1004e1:	8d 95 e4 fd ff ff    	lea    -0x21c(%ebp),%edx
  1004e7:	89 14 24             	mov    %edx,(%esp)
  1004ea:	89 44 24 04          	mov    %eax,0x4(%esp)
  1004ee:	c7 44 24 08 00 01 00 	movl   $0x100,0x8(%esp)
  1004f5:	00 
  1004f6:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
  1004fc:	e8 2e 05 00 00       	call   100a2f <strlcpy>
  100501:	b9 10 00 00 00       	mov    $0x10,%ecx
  100506:	8d 95 d4 fd ff ff    	lea    -0x22c(%ebp),%edx
  10050c:	8b b5 e4 fe ff ff    	mov    -0x11c(%ebp),%esi
  100512:	89 34 24             	mov    %esi,(%esp)
  100515:	89 54 24 04          	mov    %edx,0x4(%esp)
  100519:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  100520:	00 
  100521:	89 85 a0 fd ff ff    	mov    %eax,-0x260(%ebp)
  100527:	89 8d 9c fd ff ff    	mov    %ecx,-0x264(%ebp)
  10052d:	e8 4e fc ff ff       	call   100180 <fmt_int>
  100532:	b9 00 01 00 00       	mov    $0x100,%ecx
  100537:	8d 95 d4 fd ff ff    	lea    -0x22c(%ebp),%edx
  10053d:	8d b5 e4 fd ff ff    	lea    -0x21c(%ebp),%esi
  100543:	89 34 24             	mov    %esi,(%esp)
  100546:	89 54 24 04          	mov    %edx,0x4(%esp)
  10054a:	c7 44 24 08 00 01 00 	movl   $0x100,0x8(%esp)
  100551:	00 
  100552:	88 85 9b fd ff ff    	mov    %al,-0x265(%ebp)
  100558:	89 8d 94 fd ff ff    	mov    %ecx,-0x26c(%ebp)
  10055e:	e8 1e 05 00 00       	call   100a81 <strlcat>
  100563:	8d 0d 6e 0b 10 00    	lea    0x100b6e,%ecx
  100569:	ba 00 01 00 00       	mov    $0x100,%edx
  10056e:	8d b5 e4 fd ff ff    	lea    -0x21c(%ebp),%esi
  100574:	89 34 24             	mov    %esi,(%esp)
  100577:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  10057b:	c7 44 24 08 00 01 00 	movl   $0x100,0x8(%esp)
  100582:	00 
  100583:	89 85 90 fd ff ff    	mov    %eax,-0x270(%ebp)
  100589:	89 95 8c fd ff ff    	mov    %edx,-0x274(%ebp)
  10058f:	e8 ed 04 00 00       	call   100a81 <strlcat>
  100594:	8d 8d e4 fd ff ff    	lea    -0x21c(%ebp),%ecx
  10059a:	89 0c 24             	mov    %ecx,(%esp)
  10059d:	89 85 88 fd ff ff    	mov    %eax,-0x278(%ebp)
  1005a3:	e8 68 fb ff ff       	call   100110 <console_out>
  1005a8:	81 c4 7c 02 00 00    	add    $0x27c,%esp
  1005ae:	5e                   	pop    %esi
  1005af:	5f                   	pop    %edi
  1005b0:	5b                   	pop    %ebx
  1005b1:	5d                   	pop    %ebp
  1005b2:	c3                   	ret    

001005b3 <memcpy>:
  1005b3:	55                   	push   %ebp
  1005b4:	89 e5                	mov    %esp,%ebp
  1005b6:	83 ec 10             	sub    $0x10,%esp
  1005b9:	8b 45 08             	mov    0x8(%ebp),%eax
  1005bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1005bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005c2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1005c5:	eb 17                	jmp    1005de <memcpy+0x2b>
  1005c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1005ca:	8d 50 01             	lea    0x1(%eax),%edx
  1005cd:	89 55 fc             	mov    %edx,-0x4(%ebp)
  1005d0:	8b 55 f8             	mov    -0x8(%ebp),%edx
  1005d3:	8d 4a 01             	lea    0x1(%edx),%ecx
  1005d6:	89 4d f8             	mov    %ecx,-0x8(%ebp)
  1005d9:	0f b6 12             	movzbl (%edx),%edx
  1005dc:	88 10                	mov    %dl,(%eax)
  1005de:	8b 45 10             	mov    0x10(%ebp),%eax
  1005e1:	8d 50 ff             	lea    -0x1(%eax),%edx
  1005e4:	89 55 10             	mov    %edx,0x10(%ebp)
  1005e7:	85 c0                	test   %eax,%eax
  1005e9:	75 dc                	jne    1005c7 <memcpy+0x14>
  1005eb:	8b 45 08             	mov    0x8(%ebp),%eax
  1005ee:	c9                   	leave  
  1005ef:	c3                   	ret    

001005f0 <memmove>:
  1005f0:	55                   	push   %ebp
  1005f1:	89 e5                	mov    %esp,%ebp
  1005f3:	83 ec 10             	sub    $0x10,%esp
  1005f6:	8b 45 08             	mov    0x8(%ebp),%eax
  1005f9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1005fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005ff:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100602:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100605:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  100608:	73 28                	jae    100632 <memmove+0x42>
  10060a:	eb 17                	jmp    100623 <memmove+0x33>
  10060c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10060f:	8d 50 01             	lea    0x1(%eax),%edx
  100612:	89 55 fc             	mov    %edx,-0x4(%ebp)
  100615:	8b 55 f8             	mov    -0x8(%ebp),%edx
  100618:	8d 4a 01             	lea    0x1(%edx),%ecx
  10061b:	89 4d f8             	mov    %ecx,-0x8(%ebp)
  10061e:	0f b6 12             	movzbl (%edx),%edx
  100621:	88 10                	mov    %dl,(%eax)
  100623:	8b 45 10             	mov    0x10(%ebp),%eax
  100626:	8d 50 ff             	lea    -0x1(%eax),%edx
  100629:	89 55 10             	mov    %edx,0x10(%ebp)
  10062c:	85 c0                	test   %eax,%eax
  10062e:	75 dc                	jne    10060c <memmove+0x1c>
  100630:	eb 2e                	jmp    100660 <memmove+0x70>
  100632:	8b 45 10             	mov    0x10(%ebp),%eax
  100635:	01 45 fc             	add    %eax,-0x4(%ebp)
  100638:	8b 45 10             	mov    0x10(%ebp),%eax
  10063b:	01 45 f8             	add    %eax,-0x8(%ebp)
  10063e:	eb 13                	jmp    100653 <memmove+0x63>
  100640:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  100644:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
  100648:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10064b:	0f b6 10             	movzbl (%eax),%edx
  10064e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100651:	88 10                	mov    %dl,(%eax)
  100653:	8b 45 10             	mov    0x10(%ebp),%eax
  100656:	8d 50 ff             	lea    -0x1(%eax),%edx
  100659:	89 55 10             	mov    %edx,0x10(%ebp)
  10065c:	85 c0                	test   %eax,%eax
  10065e:	75 e0                	jne    100640 <memmove+0x50>
  100660:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100663:	c9                   	leave  
  100664:	c3                   	ret    

00100665 <memcmp>:
  100665:	55                   	push   %ebp
  100666:	89 e5                	mov    %esp,%ebp
  100668:	83 ec 10             	sub    $0x10,%esp
  10066b:	8b 45 08             	mov    0x8(%ebp),%eax
  10066e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100671:	8b 45 0c             	mov    0xc(%ebp),%eax
  100674:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100677:	eb 36                	jmp    1006af <memcmp+0x4a>
  100679:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10067c:	0f b6 10             	movzbl (%eax),%edx
  10067f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100682:	0f b6 00             	movzbl (%eax),%eax
  100685:	38 c2                	cmp    %al,%dl
  100687:	74 1e                	je     1006a7 <memcmp+0x42>
  100689:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10068c:	0f b6 10             	movzbl (%eax),%edx
  10068f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100692:	0f b6 00             	movzbl (%eax),%eax
  100695:	38 c2                	cmp    %al,%dl
  100697:	76 07                	jbe    1006a0 <memcmp+0x3b>
  100699:	b8 01 00 00 00       	mov    $0x1,%eax
  10069e:	eb 21                	jmp    1006c1 <memcmp+0x5c>
  1006a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1006a5:	eb 1a                	jmp    1006c1 <memcmp+0x5c>
  1006a7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1006ab:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  1006af:	8b 45 10             	mov    0x10(%ebp),%eax
  1006b2:	8d 50 ff             	lea    -0x1(%eax),%edx
  1006b5:	89 55 10             	mov    %edx,0x10(%ebp)
  1006b8:	85 c0                	test   %eax,%eax
  1006ba:	75 bd                	jne    100679 <memcmp+0x14>
  1006bc:	b8 00 00 00 00       	mov    $0x0,%eax
  1006c1:	c9                   	leave  
  1006c2:	c3                   	ret    

001006c3 <strcmp>:
  1006c3:	55                   	push   %ebp
  1006c4:	89 e5                	mov    %esp,%ebp
  1006c6:	83 ec 10             	sub    $0x10,%esp
  1006c9:	8b 45 08             	mov    0x8(%ebp),%eax
  1006cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1006cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006d2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1006d5:	eb 08                	jmp    1006df <strcmp+0x1c>
  1006d7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1006db:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  1006df:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1006e2:	0f b6 00             	movzbl (%eax),%eax
  1006e5:	84 c0                	test   %al,%al
  1006e7:	74 10                	je     1006f9 <strcmp+0x36>
  1006e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1006ec:	0f b6 10             	movzbl (%eax),%edx
  1006ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1006f2:	0f b6 00             	movzbl (%eax),%eax
  1006f5:	38 c2                	cmp    %al,%dl
  1006f7:	74 de                	je     1006d7 <strcmp+0x14>
  1006f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1006fc:	0f b6 10             	movzbl (%eax),%edx
  1006ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100702:	0f b6 00             	movzbl (%eax),%eax
  100705:	38 c2                	cmp    %al,%dl
  100707:	72 16                	jb     10071f <strcmp+0x5c>
  100709:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10070c:	0f b6 10             	movzbl (%eax),%edx
  10070f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100712:	0f b6 00             	movzbl (%eax),%eax
  100715:	38 c2                	cmp    %al,%dl
  100717:	0f 97 c0             	seta   %al
  10071a:	0f b6 c0             	movzbl %al,%eax
  10071d:	eb 05                	jmp    100724 <strcmp+0x61>
  10071f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100724:	c9                   	leave  
  100725:	c3                   	ret    

00100726 <memchr>:
  100726:	55                   	push   %ebp
  100727:	89 e5                	mov    %esp,%ebp
  100729:	83 ec 10             	sub    $0x10,%esp
  10072c:	8b 45 08             	mov    0x8(%ebp),%eax
  10072f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100732:	8b 45 0c             	mov    0xc(%ebp),%eax
  100735:	88 45 fb             	mov    %al,-0x5(%ebp)
  100738:	eb 14                	jmp    10074e <memchr+0x28>
  10073a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10073d:	0f b6 00             	movzbl (%eax),%eax
  100740:	3a 45 fb             	cmp    -0x5(%ebp),%al
  100743:	75 05                	jne    10074a <memchr+0x24>
  100745:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100748:	eb 16                	jmp    100760 <memchr+0x3a>
  10074a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10074e:	8b 45 10             	mov    0x10(%ebp),%eax
  100751:	8d 50 ff             	lea    -0x1(%eax),%edx
  100754:	89 55 10             	mov    %edx,0x10(%ebp)
  100757:	85 c0                	test   %eax,%eax
  100759:	75 df                	jne    10073a <memchr+0x14>
  10075b:	b8 00 00 00 00       	mov    $0x0,%eax
  100760:	c9                   	leave  
  100761:	c3                   	ret    

00100762 <strchr>:
  100762:	55                   	push   %ebp
  100763:	89 e5                	mov    %esp,%ebp
  100765:	83 ec 10             	sub    $0x10,%esp
  100768:	8b 45 0c             	mov    0xc(%ebp),%eax
  10076b:	88 45 ff             	mov    %al,-0x1(%ebp)
  10076e:	8b 45 08             	mov    0x8(%ebp),%eax
  100771:	0f b6 00             	movzbl (%eax),%eax
  100774:	3a 45 ff             	cmp    -0x1(%ebp),%al
  100777:	75 05                	jne    10077e <strchr+0x1c>
  100779:	8b 45 08             	mov    0x8(%ebp),%eax
  10077c:	eb 17                	jmp    100795 <strchr+0x33>
  10077e:	8b 45 08             	mov    0x8(%ebp),%eax
  100781:	0f b6 00             	movzbl (%eax),%eax
  100784:	84 c0                	test   %al,%al
  100786:	75 07                	jne    10078f <strchr+0x2d>
  100788:	b8 00 00 00 00       	mov    $0x0,%eax
  10078d:	eb 06                	jmp    100795 <strchr+0x33>
  10078f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  100793:	eb d9                	jmp    10076e <strchr+0xc>
  100795:	c9                   	leave  
  100796:	c3                   	ret    

00100797 <strcspn>:
  100797:	55                   	push   %ebp
  100798:	89 e5                	mov    %esp,%ebp
  10079a:	83 ec 10             	sub    $0x10,%esp
  10079d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1007a4:	eb 22                	jmp    1007c8 <strcspn+0x31>
  1007a6:	8b 55 08             	mov    0x8(%ebp),%edx
  1007a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1007ac:	01 d0                	add    %edx,%eax
  1007ae:	0f b6 00             	movzbl (%eax),%eax
  1007b1:	0f be c0             	movsbl %al,%eax
  1007b4:	50                   	push   %eax
  1007b5:	ff 75 0c             	pushl  0xc(%ebp)
  1007b8:	e8 a5 ff ff ff       	call   100762 <strchr>
  1007bd:	83 c4 08             	add    $0x8,%esp
  1007c0:	85 c0                	test   %eax,%eax
  1007c2:	75 15                	jne    1007d9 <strcspn+0x42>
  1007c4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1007c8:	8b 55 08             	mov    0x8(%ebp),%edx
  1007cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1007ce:	01 d0                	add    %edx,%eax
  1007d0:	0f b6 00             	movzbl (%eax),%eax
  1007d3:	84 c0                	test   %al,%al
  1007d5:	75 cf                	jne    1007a6 <strcspn+0xf>
  1007d7:	eb 01                	jmp    1007da <strcspn+0x43>
  1007d9:	90                   	nop
  1007da:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1007dd:	c9                   	leave  
  1007de:	c3                   	ret    

001007df <strpbrk>:
  1007df:	55                   	push   %ebp
  1007e0:	89 e5                	mov    %esp,%ebp
  1007e2:	eb 22                	jmp    100806 <strpbrk+0x27>
  1007e4:	8b 45 08             	mov    0x8(%ebp),%eax
  1007e7:	0f b6 00             	movzbl (%eax),%eax
  1007ea:	0f be c0             	movsbl %al,%eax
  1007ed:	50                   	push   %eax
  1007ee:	ff 75 0c             	pushl  0xc(%ebp)
  1007f1:	e8 6c ff ff ff       	call   100762 <strchr>
  1007f6:	83 c4 08             	add    $0x8,%esp
  1007f9:	85 c0                	test   %eax,%eax
  1007fb:	74 05                	je     100802 <strpbrk+0x23>
  1007fd:	8b 45 08             	mov    0x8(%ebp),%eax
  100800:	eb 13                	jmp    100815 <strpbrk+0x36>
  100802:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  100806:	8b 45 08             	mov    0x8(%ebp),%eax
  100809:	0f b6 00             	movzbl (%eax),%eax
  10080c:	84 c0                	test   %al,%al
  10080e:	75 d4                	jne    1007e4 <strpbrk+0x5>
  100810:	b8 00 00 00 00       	mov    $0x0,%eax
  100815:	c9                   	leave  
  100816:	c3                   	ret    

00100817 <strrchr>:
  100817:	55                   	push   %ebp
  100818:	89 e5                	mov    %esp,%ebp
  10081a:	83 ec 10             	sub    $0x10,%esp
  10081d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100820:	88 45 fb             	mov    %al,-0x5(%ebp)
  100823:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10082a:	eb 15                	jmp    100841 <strrchr+0x2a>
  10082c:	8b 45 08             	mov    0x8(%ebp),%eax
  10082f:	0f b6 00             	movzbl (%eax),%eax
  100832:	3a 45 fb             	cmp    -0x5(%ebp),%al
  100835:	75 06                	jne    10083d <strrchr+0x26>
  100837:	8b 45 08             	mov    0x8(%ebp),%eax
  10083a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10083d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  100841:	8b 45 08             	mov    0x8(%ebp),%eax
  100844:	0f b6 00             	movzbl (%eax),%eax
  100847:	84 c0                	test   %al,%al
  100849:	75 e1                	jne    10082c <strrchr+0x15>
  10084b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10084e:	c9                   	leave  
  10084f:	c3                   	ret    

00100850 <strspn>:
  100850:	55                   	push   %ebp
  100851:	89 e5                	mov    %esp,%ebp
  100853:	83 ec 10             	sub    $0x10,%esp
  100856:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10085d:	eb 22                	jmp    100881 <strspn+0x31>
  10085f:	8b 55 08             	mov    0x8(%ebp),%edx
  100862:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100865:	01 d0                	add    %edx,%eax
  100867:	0f b6 00             	movzbl (%eax),%eax
  10086a:	0f be c0             	movsbl %al,%eax
  10086d:	50                   	push   %eax
  10086e:	ff 75 0c             	pushl  0xc(%ebp)
  100871:	e8 ec fe ff ff       	call   100762 <strchr>
  100876:	83 c4 08             	add    $0x8,%esp
  100879:	85 c0                	test   %eax,%eax
  10087b:	74 15                	je     100892 <strspn+0x42>
  10087d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100881:	8b 55 08             	mov    0x8(%ebp),%edx
  100884:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100887:	01 d0                	add    %edx,%eax
  100889:	0f b6 00             	movzbl (%eax),%eax
  10088c:	84 c0                	test   %al,%al
  10088e:	75 cf                	jne    10085f <strspn+0xf>
  100890:	eb 01                	jmp    100893 <strspn+0x43>
  100892:	90                   	nop
  100893:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100896:	c9                   	leave  
  100897:	c3                   	ret    

00100898 <strstr>:
  100898:	55                   	push   %ebp
  100899:	89 e5                	mov    %esp,%ebp
  10089b:	83 ec 18             	sub    $0x18,%esp
  10089e:	83 ec 0c             	sub    $0xc,%esp
  1008a1:	ff 75 08             	pushl  0x8(%ebp)
  1008a4:	e8 2f 01 00 00       	call   1009d8 <strlen>
  1008a9:	83 c4 10             	add    $0x10,%esp
  1008ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1008af:	83 ec 0c             	sub    $0xc,%esp
  1008b2:	ff 75 0c             	pushl  0xc(%ebp)
  1008b5:	e8 1e 01 00 00       	call   1009d8 <strlen>
  1008ba:	83 c4 10             	add    $0x10,%esp
  1008bd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1008c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1008c3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  1008c6:	72 40                	jb     100908 <strstr+0x70>
  1008c8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1008cf:	eb 2c                	jmp    1008fd <strstr+0x65>
  1008d1:	8b 55 08             	mov    0x8(%ebp),%edx
  1008d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008d7:	01 d0                	add    %edx,%eax
  1008d9:	83 ec 04             	sub    $0x4,%esp
  1008dc:	ff 75 ec             	pushl  -0x14(%ebp)
  1008df:	ff 75 0c             	pushl  0xc(%ebp)
  1008e2:	50                   	push   %eax
  1008e3:	e8 7d fd ff ff       	call   100665 <memcmp>
  1008e8:	83 c4 10             	add    $0x10,%esp
  1008eb:	85 c0                	test   %eax,%eax
  1008ed:	75 0a                	jne    1008f9 <strstr+0x61>
  1008ef:	8b 55 08             	mov    0x8(%ebp),%edx
  1008f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008f5:	01 d0                	add    %edx,%eax
  1008f7:	eb 14                	jmp    10090d <strstr+0x75>
  1008f9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1008fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100900:	2b 45 ec             	sub    -0x14(%ebp),%eax
  100903:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  100906:	73 c9                	jae    1008d1 <strstr+0x39>
  100908:	b8 00 00 00 00       	mov    $0x0,%eax
  10090d:	c9                   	leave  
  10090e:	c3                   	ret    

0010090f <strtok_r>:
  10090f:	55                   	push   %ebp
  100910:	89 e5                	mov    %esp,%ebp
  100912:	83 ec 10             	sub    $0x10,%esp
  100915:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100919:	75 27                	jne    100942 <strtok_r+0x33>
  10091b:	8b 45 10             	mov    0x10(%ebp),%eax
  10091e:	8b 00                	mov    (%eax),%eax
  100920:	89 45 08             	mov    %eax,0x8(%ebp)
  100923:	eb 1d                	jmp    100942 <strtok_r+0x33>
  100925:	8b 45 08             	mov    0x8(%ebp),%eax
  100928:	0f b6 00             	movzbl (%eax),%eax
  10092b:	84 c0                	test   %al,%al
  10092d:	75 0f                	jne    10093e <strtok_r+0x2f>
  10092f:	8b 45 10             	mov    0x10(%ebp),%eax
  100932:	8b 55 08             	mov    0x8(%ebp),%edx
  100935:	89 10                	mov    %edx,(%eax)
  100937:	b8 00 00 00 00       	mov    $0x0,%eax
  10093c:	eb 6a                	jmp    1009a8 <strtok_r+0x99>
  10093e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  100942:	8b 45 08             	mov    0x8(%ebp),%eax
  100945:	0f b6 00             	movzbl (%eax),%eax
  100948:	0f be c0             	movsbl %al,%eax
  10094b:	50                   	push   %eax
  10094c:	ff 75 0c             	pushl  0xc(%ebp)
  10094f:	e8 0e fe ff ff       	call   100762 <strchr>
  100954:	83 c4 08             	add    $0x8,%esp
  100957:	85 c0                	test   %eax,%eax
  100959:	75 ca                	jne    100925 <strtok_r+0x16>
  10095b:	8b 45 08             	mov    0x8(%ebp),%eax
  10095e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100961:	eb 04                	jmp    100967 <strtok_r+0x58>
  100963:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  100967:	8b 45 08             	mov    0x8(%ebp),%eax
  10096a:	0f b6 00             	movzbl (%eax),%eax
  10096d:	0f be c0             	movsbl %al,%eax
  100970:	50                   	push   %eax
  100971:	ff 75 0c             	pushl  0xc(%ebp)
  100974:	e8 e9 fd ff ff       	call   100762 <strchr>
  100979:	83 c4 08             	add    $0x8,%esp
  10097c:	85 c0                	test   %eax,%eax
  10097e:	74 e3                	je     100963 <strtok_r+0x54>
  100980:	8b 45 08             	mov    0x8(%ebp),%eax
  100983:	0f b6 00             	movzbl (%eax),%eax
  100986:	84 c0                	test   %al,%al
  100988:	74 13                	je     10099d <strtok_r+0x8e>
  10098a:	8b 45 08             	mov    0x8(%ebp),%eax
  10098d:	c6 00 00             	movb   $0x0,(%eax)
  100990:	8b 45 08             	mov    0x8(%ebp),%eax
  100993:	8d 50 01             	lea    0x1(%eax),%edx
  100996:	8b 45 10             	mov    0x10(%ebp),%eax
  100999:	89 10                	mov    %edx,(%eax)
  10099b:	eb 08                	jmp    1009a5 <strtok_r+0x96>
  10099d:	8b 45 10             	mov    0x10(%ebp),%eax
  1009a0:	8b 55 08             	mov    0x8(%ebp),%edx
  1009a3:	89 10                	mov    %edx,(%eax)
  1009a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1009a8:	c9                   	leave  
  1009a9:	c3                   	ret    

001009aa <memset>:
  1009aa:	55                   	push   %ebp
  1009ab:	89 e5                	mov    %esp,%ebp
  1009ad:	83 ec 10             	sub    $0x10,%esp
  1009b0:	8b 45 08             	mov    0x8(%ebp),%eax
  1009b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1009b6:	eb 0e                	jmp    1009c6 <memset+0x1c>
  1009b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1009bb:	8d 50 01             	lea    0x1(%eax),%edx
  1009be:	89 55 fc             	mov    %edx,-0x4(%ebp)
  1009c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  1009c4:	88 10                	mov    %dl,(%eax)
  1009c6:	8b 45 10             	mov    0x10(%ebp),%eax
  1009c9:	8d 50 ff             	lea    -0x1(%eax),%edx
  1009cc:	89 55 10             	mov    %edx,0x10(%ebp)
  1009cf:	85 c0                	test   %eax,%eax
  1009d1:	75 e5                	jne    1009b8 <memset+0xe>
  1009d3:	8b 45 08             	mov    0x8(%ebp),%eax
  1009d6:	c9                   	leave  
  1009d7:	c3                   	ret    

001009d8 <strlen>:
  1009d8:	55                   	push   %ebp
  1009d9:	89 e5                	mov    %esp,%ebp
  1009db:	83 ec 10             	sub    $0x10,%esp
  1009de:	8b 45 08             	mov    0x8(%ebp),%eax
  1009e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1009e4:	eb 04                	jmp    1009ea <strlen+0x12>
  1009e6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1009ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1009ed:	0f b6 00             	movzbl (%eax),%eax
  1009f0:	84 c0                	test   %al,%al
  1009f2:	75 f2                	jne    1009e6 <strlen+0xe>
  1009f4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1009f7:	8b 45 08             	mov    0x8(%ebp),%eax
  1009fa:	29 c2                	sub    %eax,%edx
  1009fc:	89 d0                	mov    %edx,%eax
  1009fe:	c9                   	leave  
  1009ff:	c3                   	ret    

00100a00 <strnlen>:
  100a00:	55                   	push   %ebp
  100a01:	89 e5                	mov    %esp,%ebp
  100a03:	83 ec 10             	sub    $0x10,%esp
  100a06:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100a0d:	eb 04                	jmp    100a13 <strnlen+0x13>
  100a0f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100a13:	8b 55 08             	mov    0x8(%ebp),%edx
  100a16:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100a19:	01 d0                	add    %edx,%eax
  100a1b:	0f b6 00             	movzbl (%eax),%eax
  100a1e:	84 c0                	test   %al,%al
  100a20:	74 08                	je     100a2a <strnlen+0x2a>
  100a22:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100a25:	3b 45 0c             	cmp    0xc(%ebp),%eax
  100a28:	72 e5                	jb     100a0f <strnlen+0xf>
  100a2a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100a2d:	c9                   	leave  
  100a2e:	c3                   	ret    

00100a2f <strlcpy>:
  100a2f:	55                   	push   %ebp
  100a30:	89 e5                	mov    %esp,%ebp
  100a32:	83 ec 10             	sub    $0x10,%esp
  100a35:	ff 75 0c             	pushl  0xc(%ebp)
  100a38:	e8 9b ff ff ff       	call   1009d8 <strlen>
  100a3d:	83 c4 04             	add    $0x4,%esp
  100a40:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100a43:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  100a47:	74 33                	je     100a7c <strlcpy+0x4d>
  100a49:	8b 45 10             	mov    0x10(%ebp),%eax
  100a4c:	83 e8 01             	sub    $0x1,%eax
  100a4f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100a52:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100a55:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100a58:	73 06                	jae    100a60 <strlcpy+0x31>
  100a5a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100a5d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100a60:	ff 75 fc             	pushl  -0x4(%ebp)
  100a63:	ff 75 0c             	pushl  0xc(%ebp)
  100a66:	ff 75 08             	pushl  0x8(%ebp)
  100a69:	e8 45 fb ff ff       	call   1005b3 <memcpy>
  100a6e:	83 c4 0c             	add    $0xc,%esp
  100a71:	8b 55 08             	mov    0x8(%ebp),%edx
  100a74:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100a77:	01 d0                	add    %edx,%eax
  100a79:	c6 00 00             	movb   $0x0,(%eax)
  100a7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100a7f:	c9                   	leave  
  100a80:	c3                   	ret    

00100a81 <strlcat>:
  100a81:	55                   	push   %ebp
  100a82:	89 e5                	mov    %esp,%ebp
  100a84:	83 ec 10             	sub    $0x10,%esp
  100a87:	ff 75 0c             	pushl  0xc(%ebp)
  100a8a:	e8 49 ff ff ff       	call   1009d8 <strlen>
  100a8f:	83 c4 04             	add    $0x4,%esp
  100a92:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100a95:	ff 75 08             	pushl  0x8(%ebp)
  100a98:	e8 3b ff ff ff       	call   1009d8 <strlen>
  100a9d:	83 c4 04             	add    $0x4,%esp
  100aa0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100aa3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  100aa7:	74 49                	je     100af2 <strlcat+0x71>
  100aa9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100aac:	3b 45 10             	cmp    0x10(%ebp),%eax
  100aaf:	73 41                	jae    100af2 <strlcat+0x71>
  100ab1:	8b 45 10             	mov    0x10(%ebp),%eax
  100ab4:	2b 45 f4             	sub    -0xc(%ebp),%eax
  100ab7:	83 e8 01             	sub    $0x1,%eax
  100aba:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100abd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100ac0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100ac3:	73 06                	jae    100acb <strlcat+0x4a>
  100ac5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100ac8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100acb:	8b 55 08             	mov    0x8(%ebp),%edx
  100ace:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ad1:	01 d0                	add    %edx,%eax
  100ad3:	ff 75 fc             	pushl  -0x4(%ebp)
  100ad6:	ff 75 0c             	pushl  0xc(%ebp)
  100ad9:	50                   	push   %eax
  100ada:	e8 d4 fa ff ff       	call   1005b3 <memcpy>
  100adf:	83 c4 0c             	add    $0xc,%esp
  100ae2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100ae5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ae8:	01 c2                	add    %eax,%edx
  100aea:	8b 45 08             	mov    0x8(%ebp),%eax
  100aed:	01 d0                	add    %edx,%eax
  100aef:	c6 00 00             	movb   $0x0,(%eax)
  100af2:	8b 55 f8             	mov    -0x8(%ebp),%edx
  100af5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100af8:	01 d0                	add    %edx,%eax
  100afa:	c9                   	leave  
  100afb:	c3                   	ret    
