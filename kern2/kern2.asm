
kern2:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4                   	.byte 0xe4

0010000c <_start>:
  10000c:	bd 00 00 00 00       	mov    $0x0,%ebp
  100011:	bc 00 20 10 00       	mov    $0x102000,%esp
  100016:	55                   	push   %ebp
  100017:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
  10001c:	0f 45 1d 00 40 10 00 	cmovne 0x104000,%ebx
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
  100033:	56                   	push   %esi
  100034:	83 ec 14             	sub    $0x14,%esp
  100037:	8a 45 10             	mov    0x10(%ebp),%al
  10003a:	8a 4d 0c             	mov    0xc(%ebp),%cl
  10003d:	8b 55 08             	mov    0x8(%ebp),%edx
  100040:	0f be 75 0c          	movsbl 0xc(%ebp),%esi
  100044:	83 fe 00             	cmp    $0x0,%esi
  100047:	88 45 f3             	mov    %al,-0xd(%ebp)
  10004a:	88 4d f2             	mov    %cl,-0xe(%ebp)
  10004d:	89 55 ec             	mov    %edx,-0x14(%ebp)
  100050:	0f 8d 10 00 00 00    	jge    100066 <vga_write+0x36>
  100056:	b8 19 00 00 00       	mov    $0x19,%eax
  10005b:	0f be 4d 0c          	movsbl 0xc(%ebp),%ecx
  10005f:	29 c8                	sub    %ecx,%eax
  100061:	88 c2                	mov    %al,%dl
  100063:	88 55 0c             	mov    %dl,0xc(%ebp)
  100066:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  10006b:	0f be 4d 0c          	movsbl 0xc(%ebp),%ecx
  10006f:	c1 e1 01             	shl    $0x1,%ecx
  100072:	6b c9 50             	imul   $0x50,%ecx,%ecx
  100075:	01 c8                	add    %ecx,%eax
  100077:	89 45 f8             	mov    %eax,-0x8(%ebp)
  10007a:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
  10007e:	c6 45 f6 00          	movb   $0x0,-0xa(%ebp)
  100082:	0f b6 45 f6          	movzbl -0xa(%ebp),%eax
  100086:	83 f8 50             	cmp    $0x50,%eax
  100089:	0f 8d 7b 00 00 00    	jge    10010a <vga_write+0xda>
  10008f:	8b 45 08             	mov    0x8(%ebp),%eax
  100092:	0f b6 4d f6          	movzbl -0xa(%ebp),%ecx
  100096:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  10009a:	0f 85 04 00 00 00    	jne    1000a4 <vga_write+0x74>
  1000a0:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
  1000a4:	0f b6 45 f6          	movzbl -0xa(%ebp),%eax
  1000a8:	c1 e0 01             	shl    $0x1,%eax
  1000ab:	83 c0 01             	add    $0x1,%eax
  1000ae:	88 c1                	mov    %al,%cl
  1000b0:	88 4d f5             	mov    %cl,-0xb(%ebp)
  1000b3:	0f b6 45 f6          	movzbl -0xa(%ebp),%eax
  1000b7:	c1 e0 01             	shl    $0x1,%eax
  1000ba:	88 c1                	mov    %al,%cl
  1000bc:	88 4d f4             	mov    %cl,-0xc(%ebp)
  1000bf:	8a 4d 10             	mov    0x10(%ebp),%cl
  1000c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1000c5:	0f b6 55 f5          	movzbl -0xb(%ebp),%edx
  1000c9:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1000cc:	f6 45 f7 01          	testb  $0x1,-0x9(%ebp)
  1000d0:	0f 84 0a 00 00 00    	je     1000e0 <vga_write+0xb0>
  1000d6:	31 c0                	xor    %eax,%eax
  1000d8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1000db:	e9 0e 00 00 00       	jmp    1000ee <vga_write+0xbe>
  1000e0:	8b 45 08             	mov    0x8(%ebp),%eax
  1000e3:	0f b6 4d f6          	movzbl -0xa(%ebp),%ecx
  1000e7:	0f be 04 08          	movsbl (%eax,%ecx,1),%eax
  1000eb:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1000ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1000f1:	88 c1                	mov    %al,%cl
  1000f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1000f6:	0f b6 55 f4          	movzbl -0xc(%ebp),%edx
  1000fa:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1000fd:	8a 45 f6             	mov    -0xa(%ebp),%al
  100100:	04 01                	add    $0x1,%al
  100102:	88 45 f6             	mov    %al,-0xa(%ebp)
  100105:	e9 78 ff ff ff       	jmp    100082 <vga_write+0x52>
  10010a:	83 c4 14             	add    $0x14,%esp
  10010d:	5e                   	pop    %esi
  10010e:	5d                   	pop    %ebp
  10010f:	c3                   	ret    

00100110 <console_out>:
  100110:	55                   	push   %ebp
  100111:	89 e5                	mov    %esp,%ebp
  100113:	53                   	push   %ebx
  100114:	56                   	push   %esi
  100115:	83 ec 20             	sub    $0x20,%esp
  100118:	8b 45 08             	mov    0x8(%ebp),%eax
  10011b:	b9 02 00 00 00       	mov    $0x2,%ecx
  100120:	8b 55 08             	mov    0x8(%ebp),%edx
  100123:	8b 35 04 40 10 00    	mov    0x104004,%esi
  100129:	89 f3                	mov    %esi,%ebx
  10012b:	89 14 24             	mov    %edx,(%esp)
  10012e:	0f be d3             	movsbl %bl,%edx
  100131:	89 54 24 04          	mov    %edx,0x4(%esp)
  100135:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
  10013c:	00 
  10013d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100140:	89 4d f0             	mov    %ecx,-0x10(%ebp)
  100143:	e8 e8 fe ff ff       	call   100030 <vga_write>
  100148:	a1 04 40 10 00       	mov    0x104004,%eax
  10014d:	83 c0 01             	add    $0x1,%eax
  100150:	a3 04 40 10 00       	mov    %eax,0x104004
  100155:	83 3d 04 40 10 00 19 	cmpl   $0x19,0x104004
  10015c:	0f 8c 0a 00 00 00    	jl     10016c <console_out+0x5c>
  100162:	c7 05 04 40 10 00 00 	movl   $0x0,0x104004
  100169:	00 00 00 
  10016c:	83 c4 20             	add    $0x20,%esp
  10016f:	5e                   	pop    %esi
  100170:	5b                   	pop    %ebx
  100171:	5d                   	pop    %ebp
  100172:	c3                   	ret    
  100173:	66 66 66 66 2e 0f 1f 	data16 data16 data16 nopw %cs:0x0(%eax,%eax,1)
  10017a:	84 00 00 00 00 00 

00100180 <fmt_int>:
  100180:	55                   	push   %ebp
  100181:	89 e5                	mov    %esp,%ebp
  100183:	53                   	push   %ebx
  100184:	57                   	push   %edi
  100185:	56                   	push   %esi
  100186:	83 ec 3c             	sub    $0x3c,%esp
  100189:	8b 45 10             	mov    0x10(%ebp),%eax
  10018c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  10018f:	8b 55 08             	mov    0x8(%ebp),%edx
  100192:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
  100199:	8b 75 08             	mov    0x8(%ebp),%esi
  10019c:	89 75 e8             	mov    %esi,-0x18(%ebp)
  10019f:	8b 7d 10             	mov    0x10(%ebp),%edi
  1001a2:	89 e3                	mov    %esp,%ebx
  1001a4:	89 7b 04             	mov    %edi,0x4(%ebx)
  1001a7:	c7 03 0a 00 00 00    	movl   $0xa,(%ebx)
  1001ad:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1001b0:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  1001b3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  1001b6:	89 75 d0             	mov    %esi,-0x30(%ebp)
  1001b9:	e8 d2 00 00 00       	call   100290 <power>
  1001be:	31 c9                	xor    %ecx,%ecx
  1001c0:	8b 75 d0             	mov    -0x30(%ebp),%esi
  1001c3:	29 c6                	sub    %eax,%esi
  1001c5:	19 d1                	sbb    %edx,%ecx
  1001c7:	89 75 cc             	mov    %esi,-0x34(%ebp)
  1001ca:	89 4d c8             	mov    %ecx,-0x38(%ebp)
  1001cd:	0f 82 0e 00 00 00    	jb     1001e1 <fmt_int+0x61>
  1001d3:	e9 00 00 00 00       	jmp    1001d8 <fmt_int+0x58>
  1001d8:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
  1001dc:	e9 94 00 00 00       	jmp    100275 <fmt_int+0xf5>
  1001e1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  1001e8:	b8 0a 00 00 00       	mov    $0xa,%eax
  1001ed:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  1001f0:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  1001f3:	89 c8                	mov    %ecx,%eax
  1001f5:	31 d2                	xor    %edx,%edx
  1001f7:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  1001fa:	f7 f1                	div    %ecx
  1001fc:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1001ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100202:	83 c0 01             	add    $0x1,%eax
  100205:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  100208:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  10020c:	0f 87 d6 ff ff ff    	ja     1001e8 <fmt_int+0x68>
  100212:	8b 45 08             	mov    0x8(%ebp),%eax
  100215:	89 45 e8             	mov    %eax,-0x18(%ebp)
  100218:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10021b:	83 e8 01             	sub    $0x1,%eax
  10021e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  100221:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  100225:	0f 8c 3c 00 00 00    	jl     100267 <fmt_int+0xe7>
  10022b:	b8 0a 00 00 00       	mov    $0xa,%eax
  100230:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  100233:	89 45 c0             	mov    %eax,-0x40(%ebp)
  100236:	89 c8                	mov    %ecx,%eax
  100238:	31 d2                	xor    %edx,%edx
  10023a:	8b 4d c0             	mov    -0x40(%ebp),%ecx
  10023d:	f7 f1                	div    %ecx
  10023f:	83 c2 30             	add    $0x30,%edx
  100242:	88 d3                	mov    %dl,%bl
  100244:	8b 55 0c             	mov    0xc(%ebp),%edx
  100247:	8b 75 e0             	mov    -0x20(%ebp),%esi
  10024a:	88 1c 32             	mov    %bl,(%edx,%esi,1)
  10024d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  100250:	89 d0                	mov    %edx,%eax
  100252:	31 d2                	xor    %edx,%edx
  100254:	f7 f1                	div    %ecx
  100256:	89 45 e8             	mov    %eax,-0x18(%ebp)
  100259:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10025c:	83 c0 ff             	add    $0xffffffff,%eax
  10025f:	89 45 e0             	mov    %eax,-0x20(%ebp)
  100262:	e9 ba ff ff ff       	jmp    100221 <fmt_int+0xa1>
  100267:	8b 45 0c             	mov    0xc(%ebp),%eax
  10026a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  10026d:	c6 04 08 00          	movb   $0x0,(%eax,%ecx,1)
  100271:	c6 45 f3 01          	movb   $0x1,-0xd(%ebp)
  100275:	8a 45 f3             	mov    -0xd(%ebp),%al
  100278:	24 01                	and    $0x1,%al
  10027a:	0f b6 c0             	movzbl %al,%eax
  10027d:	83 c4 3c             	add    $0x3c,%esp
  100280:	5e                   	pop    %esi
  100281:	5f                   	pop    %edi
  100282:	5b                   	pop    %ebx
  100283:	5d                   	pop    %ebp
  100284:	c3                   	ret    
  100285:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%eax,%eax,1)
  10028c:	00 00 00 00 

00100290 <power>:
  100290:	55                   	push   %ebp
  100291:	89 e5                	mov    %esp,%ebp
  100293:	56                   	push   %esi
  100294:	83 ec 24             	sub    $0x24,%esp
  100297:	8b 45 0c             	mov    0xc(%ebp),%eax
  10029a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  10029d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1002a4:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  1002ab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  1002b2:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1002b5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  1002b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1002bb:	3b 45 0c             	cmp    0xc(%ebp),%eax
  1002be:	0f 83 32 00 00 00    	jae    1002f6 <power+0x66>
  1002c4:	8b 45 08             	mov    0x8(%ebp),%eax
  1002c7:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  1002ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1002cd:	0f af d0             	imul   %eax,%edx
  1002d0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1002d3:	89 c8                	mov    %ecx,%eax
  1002d5:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  1002d8:	89 55 dc             	mov    %edx,-0x24(%ebp)
  1002db:	f7 e1                	mul    %ecx
  1002dd:	8b 75 dc             	mov    -0x24(%ebp),%esi
  1002e0:	01 f2                	add    %esi,%edx
  1002e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1002e5:	89 55 f4             	mov    %edx,-0xc(%ebp)
  1002e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1002eb:	83 c0 01             	add    $0x1,%eax
  1002ee:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1002f1:	e9 c2 ff ff ff       	jmp    1002b8 <power+0x28>
  1002f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1002f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
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
  100313:	56                   	push   %esi
  100314:	83 ec 34             	sub    $0x34,%esp
  100317:	8b 45 08             	mov    0x8(%ebp),%eax
  10031a:	8d 0d fc 08 10 00    	lea    0x1008fc,%ecx
  100320:	ba 08 00 00 00       	mov    $0x8,%edx
  100325:	be 70 00 00 00       	mov    $0x70,%esi
  10032a:	89 0c 24             	mov    %ecx,(%esp)
  10032d:	c7 44 24 04 08 00 00 	movl   $0x8,0x4(%esp)
  100334:	00 
  100335:	c7 44 24 08 70 00 00 	movl   $0x70,0x8(%esp)
  10033c:	00 
  10033d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100340:	89 75 f4             	mov    %esi,-0xc(%ebp)
  100343:	89 55 f0             	mov    %edx,-0x10(%ebp)
  100346:	e8 e5 fc ff ff       	call   100030 <vga_write>
  10034b:	8d 05 17 09 10 00    	lea    0x100917,%eax
  100351:	b9 0c 00 00 00       	mov    $0xc,%ecx
  100356:	ba 17 00 00 00       	mov    $0x17,%edx
  10035b:	89 04 24             	mov    %eax,(%esp)
  10035e:	c7 44 24 04 0c 00 00 	movl   $0xc,0x4(%esp)
  100365:	00 
  100366:	c7 44 24 08 17 00 00 	movl   $0x17,0x8(%esp)
  10036d:	00 
  10036e:	89 55 ec             	mov    %edx,-0x14(%ebp)
  100371:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  100374:	e8 b7 fc ff ff       	call   100030 <vga_write>
  100379:	8d 05 2f 09 10 00    	lea    0x10092f,%eax
  10037f:	b9 0d 00 00 00       	mov    $0xd,%ecx
  100384:	ba 90 00 00 00       	mov    $0x90,%edx
  100389:	89 04 24             	mov    %eax,(%esp)
  10038c:	c7 44 24 04 0d 00 00 	movl   $0xd,0x4(%esp)
  100393:	00 
  100394:	c7 44 24 08 90 00 00 	movl   $0x90,0x8(%esp)
  10039b:	00 
  10039c:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  10039f:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  1003a2:	e8 89 fc ff ff       	call   100030 <vga_write>
  1003a7:	83 c4 34             	add    $0x34,%esp
  1003aa:	5e                   	pop    %esi
  1003ab:	5d                   	pop    %ebp
  1003ac:	c3                   	ret    

001003ad <memcpy>:
  1003ad:	55                   	push   %ebp
  1003ae:	89 e5                	mov    %esp,%ebp
  1003b0:	83 ec 10             	sub    $0x10,%esp
  1003b3:	8b 45 08             	mov    0x8(%ebp),%eax
  1003b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1003b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1003bc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1003bf:	eb 17                	jmp    1003d8 <memcpy+0x2b>
  1003c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1003c4:	8d 50 01             	lea    0x1(%eax),%edx
  1003c7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  1003ca:	8b 55 f8             	mov    -0x8(%ebp),%edx
  1003cd:	8d 4a 01             	lea    0x1(%edx),%ecx
  1003d0:	89 4d f8             	mov    %ecx,-0x8(%ebp)
  1003d3:	0f b6 12             	movzbl (%edx),%edx
  1003d6:	88 10                	mov    %dl,(%eax)
  1003d8:	8b 45 10             	mov    0x10(%ebp),%eax
  1003db:	8d 50 ff             	lea    -0x1(%eax),%edx
  1003de:	89 55 10             	mov    %edx,0x10(%ebp)
  1003e1:	85 c0                	test   %eax,%eax
  1003e3:	75 dc                	jne    1003c1 <memcpy+0x14>
  1003e5:	8b 45 08             	mov    0x8(%ebp),%eax
  1003e8:	c9                   	leave  
  1003e9:	c3                   	ret    

001003ea <memmove>:
  1003ea:	55                   	push   %ebp
  1003eb:	89 e5                	mov    %esp,%ebp
  1003ed:	83 ec 10             	sub    $0x10,%esp
  1003f0:	8b 45 08             	mov    0x8(%ebp),%eax
  1003f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1003f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1003f9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1003fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1003ff:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  100402:	73 28                	jae    10042c <memmove+0x42>
  100404:	eb 17                	jmp    10041d <memmove+0x33>
  100406:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100409:	8d 50 01             	lea    0x1(%eax),%edx
  10040c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  10040f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  100412:	8d 4a 01             	lea    0x1(%edx),%ecx
  100415:	89 4d f8             	mov    %ecx,-0x8(%ebp)
  100418:	0f b6 12             	movzbl (%edx),%edx
  10041b:	88 10                	mov    %dl,(%eax)
  10041d:	8b 45 10             	mov    0x10(%ebp),%eax
  100420:	8d 50 ff             	lea    -0x1(%eax),%edx
  100423:	89 55 10             	mov    %edx,0x10(%ebp)
  100426:	85 c0                	test   %eax,%eax
  100428:	75 dc                	jne    100406 <memmove+0x1c>
  10042a:	eb 2e                	jmp    10045a <memmove+0x70>
  10042c:	8b 45 10             	mov    0x10(%ebp),%eax
  10042f:	01 45 fc             	add    %eax,-0x4(%ebp)
  100432:	8b 45 10             	mov    0x10(%ebp),%eax
  100435:	01 45 f8             	add    %eax,-0x8(%ebp)
  100438:	eb 13                	jmp    10044d <memmove+0x63>
  10043a:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  10043e:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
  100442:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100445:	0f b6 10             	movzbl (%eax),%edx
  100448:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10044b:	88 10                	mov    %dl,(%eax)
  10044d:	8b 45 10             	mov    0x10(%ebp),%eax
  100450:	8d 50 ff             	lea    -0x1(%eax),%edx
  100453:	89 55 10             	mov    %edx,0x10(%ebp)
  100456:	85 c0                	test   %eax,%eax
  100458:	75 e0                	jne    10043a <memmove+0x50>
  10045a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10045d:	c9                   	leave  
  10045e:	c3                   	ret    

0010045f <memcmp>:
  10045f:	55                   	push   %ebp
  100460:	89 e5                	mov    %esp,%ebp
  100462:	83 ec 10             	sub    $0x10,%esp
  100465:	8b 45 08             	mov    0x8(%ebp),%eax
  100468:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10046b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10046e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100471:	eb 36                	jmp    1004a9 <memcmp+0x4a>
  100473:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100476:	0f b6 10             	movzbl (%eax),%edx
  100479:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10047c:	0f b6 00             	movzbl (%eax),%eax
  10047f:	38 c2                	cmp    %al,%dl
  100481:	74 1e                	je     1004a1 <memcmp+0x42>
  100483:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100486:	0f b6 10             	movzbl (%eax),%edx
  100489:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10048c:	0f b6 00             	movzbl (%eax),%eax
  10048f:	38 c2                	cmp    %al,%dl
  100491:	76 07                	jbe    10049a <memcmp+0x3b>
  100493:	b8 01 00 00 00       	mov    $0x1,%eax
  100498:	eb 21                	jmp    1004bb <memcmp+0x5c>
  10049a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10049f:	eb 1a                	jmp    1004bb <memcmp+0x5c>
  1004a1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1004a5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  1004a9:	8b 45 10             	mov    0x10(%ebp),%eax
  1004ac:	8d 50 ff             	lea    -0x1(%eax),%edx
  1004af:	89 55 10             	mov    %edx,0x10(%ebp)
  1004b2:	85 c0                	test   %eax,%eax
  1004b4:	75 bd                	jne    100473 <memcmp+0x14>
  1004b6:	b8 00 00 00 00       	mov    $0x0,%eax
  1004bb:	c9                   	leave  
  1004bc:	c3                   	ret    

001004bd <strcmp>:
  1004bd:	55                   	push   %ebp
  1004be:	89 e5                	mov    %esp,%ebp
  1004c0:	83 ec 10             	sub    $0x10,%esp
  1004c3:	8b 45 08             	mov    0x8(%ebp),%eax
  1004c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1004c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004cc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1004cf:	eb 08                	jmp    1004d9 <strcmp+0x1c>
  1004d1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1004d5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  1004d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1004dc:	0f b6 00             	movzbl (%eax),%eax
  1004df:	84 c0                	test   %al,%al
  1004e1:	74 10                	je     1004f3 <strcmp+0x36>
  1004e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1004e6:	0f b6 10             	movzbl (%eax),%edx
  1004e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1004ec:	0f b6 00             	movzbl (%eax),%eax
  1004ef:	38 c2                	cmp    %al,%dl
  1004f1:	74 de                	je     1004d1 <strcmp+0x14>
  1004f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1004f6:	0f b6 10             	movzbl (%eax),%edx
  1004f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1004fc:	0f b6 00             	movzbl (%eax),%eax
  1004ff:	38 c2                	cmp    %al,%dl
  100501:	72 16                	jb     100519 <strcmp+0x5c>
  100503:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100506:	0f b6 10             	movzbl (%eax),%edx
  100509:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10050c:	0f b6 00             	movzbl (%eax),%eax
  10050f:	38 c2                	cmp    %al,%dl
  100511:	0f 97 c0             	seta   %al
  100514:	0f b6 c0             	movzbl %al,%eax
  100517:	eb 05                	jmp    10051e <strcmp+0x61>
  100519:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10051e:	c9                   	leave  
  10051f:	c3                   	ret    

00100520 <memchr>:
  100520:	55                   	push   %ebp
  100521:	89 e5                	mov    %esp,%ebp
  100523:	83 ec 10             	sub    $0x10,%esp
  100526:	8b 45 08             	mov    0x8(%ebp),%eax
  100529:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10052c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10052f:	88 45 fb             	mov    %al,-0x5(%ebp)
  100532:	eb 14                	jmp    100548 <memchr+0x28>
  100534:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100537:	0f b6 00             	movzbl (%eax),%eax
  10053a:	3a 45 fb             	cmp    -0x5(%ebp),%al
  10053d:	75 05                	jne    100544 <memchr+0x24>
  10053f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100542:	eb 16                	jmp    10055a <memchr+0x3a>
  100544:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100548:	8b 45 10             	mov    0x10(%ebp),%eax
  10054b:	8d 50 ff             	lea    -0x1(%eax),%edx
  10054e:	89 55 10             	mov    %edx,0x10(%ebp)
  100551:	85 c0                	test   %eax,%eax
  100553:	75 df                	jne    100534 <memchr+0x14>
  100555:	b8 00 00 00 00       	mov    $0x0,%eax
  10055a:	c9                   	leave  
  10055b:	c3                   	ret    

0010055c <strchr>:
  10055c:	55                   	push   %ebp
  10055d:	89 e5                	mov    %esp,%ebp
  10055f:	83 ec 10             	sub    $0x10,%esp
  100562:	8b 45 0c             	mov    0xc(%ebp),%eax
  100565:	88 45 ff             	mov    %al,-0x1(%ebp)
  100568:	8b 45 08             	mov    0x8(%ebp),%eax
  10056b:	0f b6 00             	movzbl (%eax),%eax
  10056e:	3a 45 ff             	cmp    -0x1(%ebp),%al
  100571:	75 05                	jne    100578 <strchr+0x1c>
  100573:	8b 45 08             	mov    0x8(%ebp),%eax
  100576:	eb 17                	jmp    10058f <strchr+0x33>
  100578:	8b 45 08             	mov    0x8(%ebp),%eax
  10057b:	0f b6 00             	movzbl (%eax),%eax
  10057e:	84 c0                	test   %al,%al
  100580:	75 07                	jne    100589 <strchr+0x2d>
  100582:	b8 00 00 00 00       	mov    $0x0,%eax
  100587:	eb 06                	jmp    10058f <strchr+0x33>
  100589:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  10058d:	eb d9                	jmp    100568 <strchr+0xc>
  10058f:	c9                   	leave  
  100590:	c3                   	ret    

00100591 <strcspn>:
  100591:	55                   	push   %ebp
  100592:	89 e5                	mov    %esp,%ebp
  100594:	83 ec 10             	sub    $0x10,%esp
  100597:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10059e:	eb 22                	jmp    1005c2 <strcspn+0x31>
  1005a0:	8b 55 08             	mov    0x8(%ebp),%edx
  1005a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1005a6:	01 d0                	add    %edx,%eax
  1005a8:	0f b6 00             	movzbl (%eax),%eax
  1005ab:	0f be c0             	movsbl %al,%eax
  1005ae:	50                   	push   %eax
  1005af:	ff 75 0c             	pushl  0xc(%ebp)
  1005b2:	e8 a5 ff ff ff       	call   10055c <strchr>
  1005b7:	83 c4 08             	add    $0x8,%esp
  1005ba:	85 c0                	test   %eax,%eax
  1005bc:	75 15                	jne    1005d3 <strcspn+0x42>
  1005be:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1005c2:	8b 55 08             	mov    0x8(%ebp),%edx
  1005c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1005c8:	01 d0                	add    %edx,%eax
  1005ca:	0f b6 00             	movzbl (%eax),%eax
  1005cd:	84 c0                	test   %al,%al
  1005cf:	75 cf                	jne    1005a0 <strcspn+0xf>
  1005d1:	eb 01                	jmp    1005d4 <strcspn+0x43>
  1005d3:	90                   	nop
  1005d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1005d7:	c9                   	leave  
  1005d8:	c3                   	ret    

001005d9 <strpbrk>:
  1005d9:	55                   	push   %ebp
  1005da:	89 e5                	mov    %esp,%ebp
  1005dc:	eb 22                	jmp    100600 <strpbrk+0x27>
  1005de:	8b 45 08             	mov    0x8(%ebp),%eax
  1005e1:	0f b6 00             	movzbl (%eax),%eax
  1005e4:	0f be c0             	movsbl %al,%eax
  1005e7:	50                   	push   %eax
  1005e8:	ff 75 0c             	pushl  0xc(%ebp)
  1005eb:	e8 6c ff ff ff       	call   10055c <strchr>
  1005f0:	83 c4 08             	add    $0x8,%esp
  1005f3:	85 c0                	test   %eax,%eax
  1005f5:	74 05                	je     1005fc <strpbrk+0x23>
  1005f7:	8b 45 08             	mov    0x8(%ebp),%eax
  1005fa:	eb 13                	jmp    10060f <strpbrk+0x36>
  1005fc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  100600:	8b 45 08             	mov    0x8(%ebp),%eax
  100603:	0f b6 00             	movzbl (%eax),%eax
  100606:	84 c0                	test   %al,%al
  100608:	75 d4                	jne    1005de <strpbrk+0x5>
  10060a:	b8 00 00 00 00       	mov    $0x0,%eax
  10060f:	c9                   	leave  
  100610:	c3                   	ret    

00100611 <strrchr>:
  100611:	55                   	push   %ebp
  100612:	89 e5                	mov    %esp,%ebp
  100614:	83 ec 10             	sub    $0x10,%esp
  100617:	8b 45 0c             	mov    0xc(%ebp),%eax
  10061a:	88 45 fb             	mov    %al,-0x5(%ebp)
  10061d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100624:	eb 15                	jmp    10063b <strrchr+0x2a>
  100626:	8b 45 08             	mov    0x8(%ebp),%eax
  100629:	0f b6 00             	movzbl (%eax),%eax
  10062c:	3a 45 fb             	cmp    -0x5(%ebp),%al
  10062f:	75 06                	jne    100637 <strrchr+0x26>
  100631:	8b 45 08             	mov    0x8(%ebp),%eax
  100634:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100637:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  10063b:	8b 45 08             	mov    0x8(%ebp),%eax
  10063e:	0f b6 00             	movzbl (%eax),%eax
  100641:	84 c0                	test   %al,%al
  100643:	75 e1                	jne    100626 <strrchr+0x15>
  100645:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100648:	c9                   	leave  
  100649:	c3                   	ret    

0010064a <strspn>:
  10064a:	55                   	push   %ebp
  10064b:	89 e5                	mov    %esp,%ebp
  10064d:	83 ec 10             	sub    $0x10,%esp
  100650:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100657:	eb 22                	jmp    10067b <strspn+0x31>
  100659:	8b 55 08             	mov    0x8(%ebp),%edx
  10065c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10065f:	01 d0                	add    %edx,%eax
  100661:	0f b6 00             	movzbl (%eax),%eax
  100664:	0f be c0             	movsbl %al,%eax
  100667:	50                   	push   %eax
  100668:	ff 75 0c             	pushl  0xc(%ebp)
  10066b:	e8 ec fe ff ff       	call   10055c <strchr>
  100670:	83 c4 08             	add    $0x8,%esp
  100673:	85 c0                	test   %eax,%eax
  100675:	74 15                	je     10068c <strspn+0x42>
  100677:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10067b:	8b 55 08             	mov    0x8(%ebp),%edx
  10067e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100681:	01 d0                	add    %edx,%eax
  100683:	0f b6 00             	movzbl (%eax),%eax
  100686:	84 c0                	test   %al,%al
  100688:	75 cf                	jne    100659 <strspn+0xf>
  10068a:	eb 01                	jmp    10068d <strspn+0x43>
  10068c:	90                   	nop
  10068d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100690:	c9                   	leave  
  100691:	c3                   	ret    

00100692 <strstr>:
  100692:	55                   	push   %ebp
  100693:	89 e5                	mov    %esp,%ebp
  100695:	83 ec 18             	sub    $0x18,%esp
  100698:	83 ec 0c             	sub    $0xc,%esp
  10069b:	ff 75 08             	pushl  0x8(%ebp)
  10069e:	e8 2f 01 00 00       	call   1007d2 <strlen>
  1006a3:	83 c4 10             	add    $0x10,%esp
  1006a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1006a9:	83 ec 0c             	sub    $0xc,%esp
  1006ac:	ff 75 0c             	pushl  0xc(%ebp)
  1006af:	e8 1e 01 00 00       	call   1007d2 <strlen>
  1006b4:	83 c4 10             	add    $0x10,%esp
  1006b7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1006ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1006bd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  1006c0:	72 40                	jb     100702 <strstr+0x70>
  1006c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1006c9:	eb 2c                	jmp    1006f7 <strstr+0x65>
  1006cb:	8b 55 08             	mov    0x8(%ebp),%edx
  1006ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006d1:	01 d0                	add    %edx,%eax
  1006d3:	83 ec 04             	sub    $0x4,%esp
  1006d6:	ff 75 ec             	pushl  -0x14(%ebp)
  1006d9:	ff 75 0c             	pushl  0xc(%ebp)
  1006dc:	50                   	push   %eax
  1006dd:	e8 7d fd ff ff       	call   10045f <memcmp>
  1006e2:	83 c4 10             	add    $0x10,%esp
  1006e5:	85 c0                	test   %eax,%eax
  1006e7:	75 0a                	jne    1006f3 <strstr+0x61>
  1006e9:	8b 55 08             	mov    0x8(%ebp),%edx
  1006ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006ef:	01 d0                	add    %edx,%eax
  1006f1:	eb 14                	jmp    100707 <strstr+0x75>
  1006f3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1006f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1006fa:	2b 45 ec             	sub    -0x14(%ebp),%eax
  1006fd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  100700:	73 c9                	jae    1006cb <strstr+0x39>
  100702:	b8 00 00 00 00       	mov    $0x0,%eax
  100707:	c9                   	leave  
  100708:	c3                   	ret    

00100709 <strtok_r>:
  100709:	55                   	push   %ebp
  10070a:	89 e5                	mov    %esp,%ebp
  10070c:	83 ec 10             	sub    $0x10,%esp
  10070f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100713:	75 27                	jne    10073c <strtok_r+0x33>
  100715:	8b 45 10             	mov    0x10(%ebp),%eax
  100718:	8b 00                	mov    (%eax),%eax
  10071a:	89 45 08             	mov    %eax,0x8(%ebp)
  10071d:	eb 1d                	jmp    10073c <strtok_r+0x33>
  10071f:	8b 45 08             	mov    0x8(%ebp),%eax
  100722:	0f b6 00             	movzbl (%eax),%eax
  100725:	84 c0                	test   %al,%al
  100727:	75 0f                	jne    100738 <strtok_r+0x2f>
  100729:	8b 45 10             	mov    0x10(%ebp),%eax
  10072c:	8b 55 08             	mov    0x8(%ebp),%edx
  10072f:	89 10                	mov    %edx,(%eax)
  100731:	b8 00 00 00 00       	mov    $0x0,%eax
  100736:	eb 6a                	jmp    1007a2 <strtok_r+0x99>
  100738:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  10073c:	8b 45 08             	mov    0x8(%ebp),%eax
  10073f:	0f b6 00             	movzbl (%eax),%eax
  100742:	0f be c0             	movsbl %al,%eax
  100745:	50                   	push   %eax
  100746:	ff 75 0c             	pushl  0xc(%ebp)
  100749:	e8 0e fe ff ff       	call   10055c <strchr>
  10074e:	83 c4 08             	add    $0x8,%esp
  100751:	85 c0                	test   %eax,%eax
  100753:	75 ca                	jne    10071f <strtok_r+0x16>
  100755:	8b 45 08             	mov    0x8(%ebp),%eax
  100758:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10075b:	eb 04                	jmp    100761 <strtok_r+0x58>
  10075d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  100761:	8b 45 08             	mov    0x8(%ebp),%eax
  100764:	0f b6 00             	movzbl (%eax),%eax
  100767:	0f be c0             	movsbl %al,%eax
  10076a:	50                   	push   %eax
  10076b:	ff 75 0c             	pushl  0xc(%ebp)
  10076e:	e8 e9 fd ff ff       	call   10055c <strchr>
  100773:	83 c4 08             	add    $0x8,%esp
  100776:	85 c0                	test   %eax,%eax
  100778:	74 e3                	je     10075d <strtok_r+0x54>
  10077a:	8b 45 08             	mov    0x8(%ebp),%eax
  10077d:	0f b6 00             	movzbl (%eax),%eax
  100780:	84 c0                	test   %al,%al
  100782:	74 13                	je     100797 <strtok_r+0x8e>
  100784:	8b 45 08             	mov    0x8(%ebp),%eax
  100787:	c6 00 00             	movb   $0x0,(%eax)
  10078a:	8b 45 08             	mov    0x8(%ebp),%eax
  10078d:	8d 50 01             	lea    0x1(%eax),%edx
  100790:	8b 45 10             	mov    0x10(%ebp),%eax
  100793:	89 10                	mov    %edx,(%eax)
  100795:	eb 08                	jmp    10079f <strtok_r+0x96>
  100797:	8b 45 10             	mov    0x10(%ebp),%eax
  10079a:	8b 55 08             	mov    0x8(%ebp),%edx
  10079d:	89 10                	mov    %edx,(%eax)
  10079f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1007a2:	c9                   	leave  
  1007a3:	c3                   	ret    

001007a4 <memset>:
  1007a4:	55                   	push   %ebp
  1007a5:	89 e5                	mov    %esp,%ebp
  1007a7:	83 ec 10             	sub    $0x10,%esp
  1007aa:	8b 45 08             	mov    0x8(%ebp),%eax
  1007ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1007b0:	eb 0e                	jmp    1007c0 <memset+0x1c>
  1007b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1007b5:	8d 50 01             	lea    0x1(%eax),%edx
  1007b8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  1007bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  1007be:	88 10                	mov    %dl,(%eax)
  1007c0:	8b 45 10             	mov    0x10(%ebp),%eax
  1007c3:	8d 50 ff             	lea    -0x1(%eax),%edx
  1007c6:	89 55 10             	mov    %edx,0x10(%ebp)
  1007c9:	85 c0                	test   %eax,%eax
  1007cb:	75 e5                	jne    1007b2 <memset+0xe>
  1007cd:	8b 45 08             	mov    0x8(%ebp),%eax
  1007d0:	c9                   	leave  
  1007d1:	c3                   	ret    

001007d2 <strlen>:
  1007d2:	55                   	push   %ebp
  1007d3:	89 e5                	mov    %esp,%ebp
  1007d5:	83 ec 10             	sub    $0x10,%esp
  1007d8:	8b 45 08             	mov    0x8(%ebp),%eax
  1007db:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1007de:	eb 04                	jmp    1007e4 <strlen+0x12>
  1007e0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1007e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1007e7:	0f b6 00             	movzbl (%eax),%eax
  1007ea:	84 c0                	test   %al,%al
  1007ec:	75 f2                	jne    1007e0 <strlen+0xe>
  1007ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1007f1:	8b 45 08             	mov    0x8(%ebp),%eax
  1007f4:	29 c2                	sub    %eax,%edx
  1007f6:	89 d0                	mov    %edx,%eax
  1007f8:	c9                   	leave  
  1007f9:	c3                   	ret    

001007fa <strnlen>:
  1007fa:	55                   	push   %ebp
  1007fb:	89 e5                	mov    %esp,%ebp
  1007fd:	83 ec 10             	sub    $0x10,%esp
  100800:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100807:	eb 04                	jmp    10080d <strnlen+0x13>
  100809:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10080d:	8b 55 08             	mov    0x8(%ebp),%edx
  100810:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100813:	01 d0                	add    %edx,%eax
  100815:	0f b6 00             	movzbl (%eax),%eax
  100818:	84 c0                	test   %al,%al
  10081a:	74 08                	je     100824 <strnlen+0x2a>
  10081c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10081f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  100822:	72 e5                	jb     100809 <strnlen+0xf>
  100824:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100827:	c9                   	leave  
  100828:	c3                   	ret    

00100829 <strlcpy>:
  100829:	55                   	push   %ebp
  10082a:	89 e5                	mov    %esp,%ebp
  10082c:	83 ec 10             	sub    $0x10,%esp
  10082f:	ff 75 0c             	pushl  0xc(%ebp)
  100832:	e8 9b ff ff ff       	call   1007d2 <strlen>
  100837:	83 c4 04             	add    $0x4,%esp
  10083a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  10083d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  100841:	74 33                	je     100876 <strlcpy+0x4d>
  100843:	8b 45 10             	mov    0x10(%ebp),%eax
  100846:	83 e8 01             	sub    $0x1,%eax
  100849:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10084c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10084f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100852:	73 06                	jae    10085a <strlcpy+0x31>
  100854:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100857:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10085a:	ff 75 fc             	pushl  -0x4(%ebp)
  10085d:	ff 75 0c             	pushl  0xc(%ebp)
  100860:	ff 75 08             	pushl  0x8(%ebp)
  100863:	e8 45 fb ff ff       	call   1003ad <memcpy>
  100868:	83 c4 0c             	add    $0xc,%esp
  10086b:	8b 55 08             	mov    0x8(%ebp),%edx
  10086e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100871:	01 d0                	add    %edx,%eax
  100873:	c6 00 00             	movb   $0x0,(%eax)
  100876:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100879:	c9                   	leave  
  10087a:	c3                   	ret    

0010087b <strlcat>:
  10087b:	55                   	push   %ebp
  10087c:	89 e5                	mov    %esp,%ebp
  10087e:	83 ec 10             	sub    $0x10,%esp
  100881:	ff 75 0c             	pushl  0xc(%ebp)
  100884:	e8 49 ff ff ff       	call   1007d2 <strlen>
  100889:	83 c4 04             	add    $0x4,%esp
  10088c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  10088f:	ff 75 08             	pushl  0x8(%ebp)
  100892:	e8 3b ff ff ff       	call   1007d2 <strlen>
  100897:	83 c4 04             	add    $0x4,%esp
  10089a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10089d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1008a1:	74 49                	je     1008ec <strlcat+0x71>
  1008a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008a6:	3b 45 10             	cmp    0x10(%ebp),%eax
  1008a9:	73 41                	jae    1008ec <strlcat+0x71>
  1008ab:	8b 45 10             	mov    0x10(%ebp),%eax
  1008ae:	2b 45 f4             	sub    -0xc(%ebp),%eax
  1008b1:	83 e8 01             	sub    $0x1,%eax
  1008b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1008b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1008ba:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1008bd:	73 06                	jae    1008c5 <strlcat+0x4a>
  1008bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1008c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1008c5:	8b 55 08             	mov    0x8(%ebp),%edx
  1008c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008cb:	01 d0                	add    %edx,%eax
  1008cd:	ff 75 fc             	pushl  -0x4(%ebp)
  1008d0:	ff 75 0c             	pushl  0xc(%ebp)
  1008d3:	50                   	push   %eax
  1008d4:	e8 d4 fa ff ff       	call   1003ad <memcpy>
  1008d9:	83 c4 0c             	add    $0xc,%esp
  1008dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1008df:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1008e2:	01 c2                	add    %eax,%edx
  1008e4:	8b 45 08             	mov    0x8(%ebp),%eax
  1008e7:	01 d0                	add    %edx,%eax
  1008e9:	c6 00 00             	movb   $0x0,(%eax)
  1008ec:	8b 55 f8             	mov    -0x8(%ebp),%edx
  1008ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008f2:	01 d0                	add    %edx,%eax
  1008f4:	c9                   	leave  
  1008f5:	c3                   	ret    
