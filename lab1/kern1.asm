
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
  100024:	e8 e7 00 00 00       	call   100110 <kmain>

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
  100065:	a1 cc 07 10 00       	mov    0x1007cc,%eax
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

00100110 <kmain>:
  100110:	55                   	push   %ebp
  100111:	89 e5                	mov    %esp,%ebp
  100113:	56                   	push   %esi
  100114:	81 ec 44 01 00 00    	sub    $0x144,%esp
  10011a:	8b 45 08             	mov    0x8(%ebp),%eax
  10011d:	8d 0d d0 07 10 00    	lea    0x1007d0,%ecx
  100123:	ba 01 00 00 00       	mov    $0x1,%edx
  100128:	be 70 00 00 00       	mov    $0x70,%esi
  10012d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100130:	89 0c 24             	mov    %ecx,(%esp)
  100133:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10013a:	00 
  10013b:	c7 44 24 08 70 00 00 	movl   $0x70,0x8(%esp)
  100142:	00 
  100143:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
  100149:	89 95 ec fe ff ff    	mov    %edx,-0x114(%ebp)
  10014f:	e8 dc fe ff ff       	call   100030 <vga_write>
  100154:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  100158:	0f 85 39 00 00 00    	jne    100197 <kmain+0x87>
  10015e:	8d 05 eb 07 10 00    	lea    0x1007eb,%eax
  100164:	b9 02 00 00 00       	mov    $0x2,%ecx
  100169:	ba 70 00 00 00       	mov    $0x70,%edx
  10016e:	89 04 24             	mov    %eax,(%esp)
  100171:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  100178:	00 
  100179:	c7 44 24 08 70 00 00 	movl   $0x70,0x8(%esp)
  100180:	00 
  100181:	89 95 e8 fe ff ff    	mov    %edx,-0x118(%ebp)
  100187:	89 8d e4 fe ff ff    	mov    %ecx,-0x11c(%ebp)
  10018d:	e8 9e fe ff ff       	call   100030 <vga_write>
  100192:	e9 e2 00 00 00       	jmp    100279 <kmain+0x169>
  100197:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10019a:	8b 00                	mov    (%eax),%eax
  10019c:	83 e0 04             	and    $0x4,%eax
  10019f:	83 f8 00             	cmp    $0x0,%eax
  1001a2:	0f 84 98 00 00 00    	je     100240 <kmain+0x130>
  1001a8:	b8 00 01 00 00       	mov    $0x100,%eax
  1001ad:	8d 8d f4 fe ff ff    	lea    -0x10c(%ebp),%ecx
  1001b3:	8d 15 2b 08 10 00    	lea    0x10082b,%edx
  1001b9:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1001bc:	8b 76 10             	mov    0x10(%esi),%esi
  1001bf:	89 75 f4             	mov    %esi,-0xc(%ebp)
  1001c2:	89 ce                	mov    %ecx,%esi
  1001c4:	89 34 24             	mov    %esi,(%esp)
  1001c7:	89 54 24 04          	mov    %edx,0x4(%esp)
  1001cb:	c7 44 24 08 00 01 00 	movl   $0x100,0x8(%esp)
  1001d2:	00 
  1001d3:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
  1001d9:	89 8d dc fe ff ff    	mov    %ecx,-0x124(%ebp)
  1001df:	e8 9e 00 00 00       	call   100282 <memcpy>
  1001e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1001e7:	8b 8d dc fe ff ff    	mov    -0x124(%ebp),%ecx
  1001ed:	89 0c 24             	mov    %ecx,(%esp)
  1001f0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001f4:	c7 44 24 08 00 01 00 	movl   $0x100,0x8(%esp)
  1001fb:	00 
  1001fc:	e8 4f 05 00 00       	call   100750 <strlcat>
  100201:	b9 02 00 00 00       	mov    $0x2,%ecx
  100206:	ba 70 00 00 00       	mov    $0x70,%edx
  10020b:	8d b5 f4 fe ff ff    	lea    -0x10c(%ebp),%esi
  100211:	89 34 24             	mov    %esi,(%esp)
  100214:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  10021b:	00 
  10021c:	c7 44 24 08 70 00 00 	movl   $0x70,0x8(%esp)
  100223:	00 
  100224:	89 85 d8 fe ff ff    	mov    %eax,-0x128(%ebp)
  10022a:	89 8d d4 fe ff ff    	mov    %ecx,-0x12c(%ebp)
  100230:	89 95 d0 fe ff ff    	mov    %edx,-0x130(%ebp)
  100236:	e8 f5 fd ff ff       	call   100030 <vga_write>
  10023b:	e9 34 00 00 00       	jmp    100274 <kmain+0x164>
  100240:	8d 05 08 08 10 00    	lea    0x100808,%eax
  100246:	b9 03 00 00 00       	mov    $0x3,%ecx
  10024b:	ba 70 00 00 00       	mov    $0x70,%edx
  100250:	89 04 24             	mov    %eax,(%esp)
  100253:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
  10025a:	00 
  10025b:	c7 44 24 08 70 00 00 	movl   $0x70,0x8(%esp)
  100262:	00 
  100263:	89 95 cc fe ff ff    	mov    %edx,-0x134(%ebp)
  100269:	89 8d c8 fe ff ff    	mov    %ecx,-0x138(%ebp)
  10026f:	e8 bc fd ff ff       	call   100030 <vga_write>
  100274:	e9 00 00 00 00       	jmp    100279 <kmain+0x169>
  100279:	81 c4 44 01 00 00    	add    $0x144,%esp
  10027f:	5e                   	pop    %esi
  100280:	5d                   	pop    %ebp
  100281:	c3                   	ret    

00100282 <memcpy>:
  100282:	55                   	push   %ebp
  100283:	89 e5                	mov    %esp,%ebp
  100285:	83 ec 10             	sub    $0x10,%esp
  100288:	8b 45 08             	mov    0x8(%ebp),%eax
  10028b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10028e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100291:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100294:	eb 17                	jmp    1002ad <memcpy+0x2b>
  100296:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100299:	8d 50 01             	lea    0x1(%eax),%edx
  10029c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  10029f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  1002a2:	8d 4a 01             	lea    0x1(%edx),%ecx
  1002a5:	89 4d f8             	mov    %ecx,-0x8(%ebp)
  1002a8:	0f b6 12             	movzbl (%edx),%edx
  1002ab:	88 10                	mov    %dl,(%eax)
  1002ad:	8b 45 10             	mov    0x10(%ebp),%eax
  1002b0:	8d 50 ff             	lea    -0x1(%eax),%edx
  1002b3:	89 55 10             	mov    %edx,0x10(%ebp)
  1002b6:	85 c0                	test   %eax,%eax
  1002b8:	75 dc                	jne    100296 <memcpy+0x14>
  1002ba:	8b 45 08             	mov    0x8(%ebp),%eax
  1002bd:	c9                   	leave  
  1002be:	c3                   	ret    

001002bf <memmove>:
  1002bf:	55                   	push   %ebp
  1002c0:	89 e5                	mov    %esp,%ebp
  1002c2:	83 ec 10             	sub    $0x10,%esp
  1002c5:	8b 45 08             	mov    0x8(%ebp),%eax
  1002c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1002cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002ce:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1002d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1002d4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1002d7:	73 28                	jae    100301 <memmove+0x42>
  1002d9:	eb 17                	jmp    1002f2 <memmove+0x33>
  1002db:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1002de:	8d 50 01             	lea    0x1(%eax),%edx
  1002e1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  1002e4:	8b 55 f8             	mov    -0x8(%ebp),%edx
  1002e7:	8d 4a 01             	lea    0x1(%edx),%ecx
  1002ea:	89 4d f8             	mov    %ecx,-0x8(%ebp)
  1002ed:	0f b6 12             	movzbl (%edx),%edx
  1002f0:	88 10                	mov    %dl,(%eax)
  1002f2:	8b 45 10             	mov    0x10(%ebp),%eax
  1002f5:	8d 50 ff             	lea    -0x1(%eax),%edx
  1002f8:	89 55 10             	mov    %edx,0x10(%ebp)
  1002fb:	85 c0                	test   %eax,%eax
  1002fd:	75 dc                	jne    1002db <memmove+0x1c>
  1002ff:	eb 2e                	jmp    10032f <memmove+0x70>
  100301:	8b 45 10             	mov    0x10(%ebp),%eax
  100304:	01 45 fc             	add    %eax,-0x4(%ebp)
  100307:	8b 45 10             	mov    0x10(%ebp),%eax
  10030a:	01 45 f8             	add    %eax,-0x8(%ebp)
  10030d:	eb 13                	jmp    100322 <memmove+0x63>
  10030f:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  100313:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
  100317:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10031a:	0f b6 10             	movzbl (%eax),%edx
  10031d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100320:	88 10                	mov    %dl,(%eax)
  100322:	8b 45 10             	mov    0x10(%ebp),%eax
  100325:	8d 50 ff             	lea    -0x1(%eax),%edx
  100328:	89 55 10             	mov    %edx,0x10(%ebp)
  10032b:	85 c0                	test   %eax,%eax
  10032d:	75 e0                	jne    10030f <memmove+0x50>
  10032f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100332:	c9                   	leave  
  100333:	c3                   	ret    

00100334 <memcmp>:
  100334:	55                   	push   %ebp
  100335:	89 e5                	mov    %esp,%ebp
  100337:	83 ec 10             	sub    $0x10,%esp
  10033a:	8b 45 08             	mov    0x8(%ebp),%eax
  10033d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100340:	8b 45 0c             	mov    0xc(%ebp),%eax
  100343:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100346:	eb 36                	jmp    10037e <memcmp+0x4a>
  100348:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10034b:	0f b6 10             	movzbl (%eax),%edx
  10034e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100351:	0f b6 00             	movzbl (%eax),%eax
  100354:	38 c2                	cmp    %al,%dl
  100356:	74 1e                	je     100376 <memcmp+0x42>
  100358:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10035b:	0f b6 10             	movzbl (%eax),%edx
  10035e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100361:	0f b6 00             	movzbl (%eax),%eax
  100364:	38 c2                	cmp    %al,%dl
  100366:	76 07                	jbe    10036f <memcmp+0x3b>
  100368:	b8 01 00 00 00       	mov    $0x1,%eax
  10036d:	eb 21                	jmp    100390 <memcmp+0x5c>
  10036f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100374:	eb 1a                	jmp    100390 <memcmp+0x5c>
  100376:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10037a:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  10037e:	8b 45 10             	mov    0x10(%ebp),%eax
  100381:	8d 50 ff             	lea    -0x1(%eax),%edx
  100384:	89 55 10             	mov    %edx,0x10(%ebp)
  100387:	85 c0                	test   %eax,%eax
  100389:	75 bd                	jne    100348 <memcmp+0x14>
  10038b:	b8 00 00 00 00       	mov    $0x0,%eax
  100390:	c9                   	leave  
  100391:	c3                   	ret    

00100392 <strcmp>:
  100392:	55                   	push   %ebp
  100393:	89 e5                	mov    %esp,%ebp
  100395:	83 ec 10             	sub    $0x10,%esp
  100398:	8b 45 08             	mov    0x8(%ebp),%eax
  10039b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10039e:	8b 45 0c             	mov    0xc(%ebp),%eax
  1003a1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1003a4:	eb 08                	jmp    1003ae <strcmp+0x1c>
  1003a6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1003aa:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  1003ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1003b1:	0f b6 00             	movzbl (%eax),%eax
  1003b4:	84 c0                	test   %al,%al
  1003b6:	74 10                	je     1003c8 <strcmp+0x36>
  1003b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1003bb:	0f b6 10             	movzbl (%eax),%edx
  1003be:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1003c1:	0f b6 00             	movzbl (%eax),%eax
  1003c4:	38 c2                	cmp    %al,%dl
  1003c6:	74 de                	je     1003a6 <strcmp+0x14>
  1003c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1003cb:	0f b6 10             	movzbl (%eax),%edx
  1003ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1003d1:	0f b6 00             	movzbl (%eax),%eax
  1003d4:	38 c2                	cmp    %al,%dl
  1003d6:	72 16                	jb     1003ee <strcmp+0x5c>
  1003d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1003db:	0f b6 10             	movzbl (%eax),%edx
  1003de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1003e1:	0f b6 00             	movzbl (%eax),%eax
  1003e4:	38 c2                	cmp    %al,%dl
  1003e6:	0f 97 c0             	seta   %al
  1003e9:	0f b6 c0             	movzbl %al,%eax
  1003ec:	eb 05                	jmp    1003f3 <strcmp+0x61>
  1003ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1003f3:	c9                   	leave  
  1003f4:	c3                   	ret    

001003f5 <memchr>:
  1003f5:	55                   	push   %ebp
  1003f6:	89 e5                	mov    %esp,%ebp
  1003f8:	83 ec 10             	sub    $0x10,%esp
  1003fb:	8b 45 08             	mov    0x8(%ebp),%eax
  1003fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100401:	8b 45 0c             	mov    0xc(%ebp),%eax
  100404:	88 45 fb             	mov    %al,-0x5(%ebp)
  100407:	eb 14                	jmp    10041d <memchr+0x28>
  100409:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10040c:	0f b6 00             	movzbl (%eax),%eax
  10040f:	3a 45 fb             	cmp    -0x5(%ebp),%al
  100412:	75 05                	jne    100419 <memchr+0x24>
  100414:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100417:	eb 16                	jmp    10042f <memchr+0x3a>
  100419:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10041d:	8b 45 10             	mov    0x10(%ebp),%eax
  100420:	8d 50 ff             	lea    -0x1(%eax),%edx
  100423:	89 55 10             	mov    %edx,0x10(%ebp)
  100426:	85 c0                	test   %eax,%eax
  100428:	75 df                	jne    100409 <memchr+0x14>
  10042a:	b8 00 00 00 00       	mov    $0x0,%eax
  10042f:	c9                   	leave  
  100430:	c3                   	ret    

00100431 <strchr>:
  100431:	55                   	push   %ebp
  100432:	89 e5                	mov    %esp,%ebp
  100434:	83 ec 10             	sub    $0x10,%esp
  100437:	8b 45 0c             	mov    0xc(%ebp),%eax
  10043a:	88 45 ff             	mov    %al,-0x1(%ebp)
  10043d:	8b 45 08             	mov    0x8(%ebp),%eax
  100440:	0f b6 00             	movzbl (%eax),%eax
  100443:	3a 45 ff             	cmp    -0x1(%ebp),%al
  100446:	75 05                	jne    10044d <strchr+0x1c>
  100448:	8b 45 08             	mov    0x8(%ebp),%eax
  10044b:	eb 17                	jmp    100464 <strchr+0x33>
  10044d:	8b 45 08             	mov    0x8(%ebp),%eax
  100450:	0f b6 00             	movzbl (%eax),%eax
  100453:	84 c0                	test   %al,%al
  100455:	75 07                	jne    10045e <strchr+0x2d>
  100457:	b8 00 00 00 00       	mov    $0x0,%eax
  10045c:	eb 06                	jmp    100464 <strchr+0x33>
  10045e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  100462:	eb d9                	jmp    10043d <strchr+0xc>
  100464:	c9                   	leave  
  100465:	c3                   	ret    

00100466 <strcspn>:
  100466:	55                   	push   %ebp
  100467:	89 e5                	mov    %esp,%ebp
  100469:	83 ec 10             	sub    $0x10,%esp
  10046c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100473:	eb 22                	jmp    100497 <strcspn+0x31>
  100475:	8b 55 08             	mov    0x8(%ebp),%edx
  100478:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10047b:	01 d0                	add    %edx,%eax
  10047d:	0f b6 00             	movzbl (%eax),%eax
  100480:	0f be c0             	movsbl %al,%eax
  100483:	50                   	push   %eax
  100484:	ff 75 0c             	pushl  0xc(%ebp)
  100487:	e8 a5 ff ff ff       	call   100431 <strchr>
  10048c:	83 c4 08             	add    $0x8,%esp
  10048f:	85 c0                	test   %eax,%eax
  100491:	75 15                	jne    1004a8 <strcspn+0x42>
  100493:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100497:	8b 55 08             	mov    0x8(%ebp),%edx
  10049a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10049d:	01 d0                	add    %edx,%eax
  10049f:	0f b6 00             	movzbl (%eax),%eax
  1004a2:	84 c0                	test   %al,%al
  1004a4:	75 cf                	jne    100475 <strcspn+0xf>
  1004a6:	eb 01                	jmp    1004a9 <strcspn+0x43>
  1004a8:	90                   	nop
  1004a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1004ac:	c9                   	leave  
  1004ad:	c3                   	ret    

001004ae <strpbrk>:
  1004ae:	55                   	push   %ebp
  1004af:	89 e5                	mov    %esp,%ebp
  1004b1:	eb 22                	jmp    1004d5 <strpbrk+0x27>
  1004b3:	8b 45 08             	mov    0x8(%ebp),%eax
  1004b6:	0f b6 00             	movzbl (%eax),%eax
  1004b9:	0f be c0             	movsbl %al,%eax
  1004bc:	50                   	push   %eax
  1004bd:	ff 75 0c             	pushl  0xc(%ebp)
  1004c0:	e8 6c ff ff ff       	call   100431 <strchr>
  1004c5:	83 c4 08             	add    $0x8,%esp
  1004c8:	85 c0                	test   %eax,%eax
  1004ca:	74 05                	je     1004d1 <strpbrk+0x23>
  1004cc:	8b 45 08             	mov    0x8(%ebp),%eax
  1004cf:	eb 13                	jmp    1004e4 <strpbrk+0x36>
  1004d1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1004d5:	8b 45 08             	mov    0x8(%ebp),%eax
  1004d8:	0f b6 00             	movzbl (%eax),%eax
  1004db:	84 c0                	test   %al,%al
  1004dd:	75 d4                	jne    1004b3 <strpbrk+0x5>
  1004df:	b8 00 00 00 00       	mov    $0x0,%eax
  1004e4:	c9                   	leave  
  1004e5:	c3                   	ret    

001004e6 <strrchr>:
  1004e6:	55                   	push   %ebp
  1004e7:	89 e5                	mov    %esp,%ebp
  1004e9:	83 ec 10             	sub    $0x10,%esp
  1004ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004ef:	88 45 fb             	mov    %al,-0x5(%ebp)
  1004f2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1004f9:	eb 15                	jmp    100510 <strrchr+0x2a>
  1004fb:	8b 45 08             	mov    0x8(%ebp),%eax
  1004fe:	0f b6 00             	movzbl (%eax),%eax
  100501:	3a 45 fb             	cmp    -0x5(%ebp),%al
  100504:	75 06                	jne    10050c <strrchr+0x26>
  100506:	8b 45 08             	mov    0x8(%ebp),%eax
  100509:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10050c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  100510:	8b 45 08             	mov    0x8(%ebp),%eax
  100513:	0f b6 00             	movzbl (%eax),%eax
  100516:	84 c0                	test   %al,%al
  100518:	75 e1                	jne    1004fb <strrchr+0x15>
  10051a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10051d:	c9                   	leave  
  10051e:	c3                   	ret    

0010051f <strspn>:
  10051f:	55                   	push   %ebp
  100520:	89 e5                	mov    %esp,%ebp
  100522:	83 ec 10             	sub    $0x10,%esp
  100525:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10052c:	eb 22                	jmp    100550 <strspn+0x31>
  10052e:	8b 55 08             	mov    0x8(%ebp),%edx
  100531:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100534:	01 d0                	add    %edx,%eax
  100536:	0f b6 00             	movzbl (%eax),%eax
  100539:	0f be c0             	movsbl %al,%eax
  10053c:	50                   	push   %eax
  10053d:	ff 75 0c             	pushl  0xc(%ebp)
  100540:	e8 ec fe ff ff       	call   100431 <strchr>
  100545:	83 c4 08             	add    $0x8,%esp
  100548:	85 c0                	test   %eax,%eax
  10054a:	74 15                	je     100561 <strspn+0x42>
  10054c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100550:	8b 55 08             	mov    0x8(%ebp),%edx
  100553:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100556:	01 d0                	add    %edx,%eax
  100558:	0f b6 00             	movzbl (%eax),%eax
  10055b:	84 c0                	test   %al,%al
  10055d:	75 cf                	jne    10052e <strspn+0xf>
  10055f:	eb 01                	jmp    100562 <strspn+0x43>
  100561:	90                   	nop
  100562:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100565:	c9                   	leave  
  100566:	c3                   	ret    

00100567 <strstr>:
  100567:	55                   	push   %ebp
  100568:	89 e5                	mov    %esp,%ebp
  10056a:	83 ec 18             	sub    $0x18,%esp
  10056d:	83 ec 0c             	sub    $0xc,%esp
  100570:	ff 75 08             	pushl  0x8(%ebp)
  100573:	e8 2f 01 00 00       	call   1006a7 <strlen>
  100578:	83 c4 10             	add    $0x10,%esp
  10057b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10057e:	83 ec 0c             	sub    $0xc,%esp
  100581:	ff 75 0c             	pushl  0xc(%ebp)
  100584:	e8 1e 01 00 00       	call   1006a7 <strlen>
  100589:	83 c4 10             	add    $0x10,%esp
  10058c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10058f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100592:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  100595:	72 40                	jb     1005d7 <strstr+0x70>
  100597:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  10059e:	eb 2c                	jmp    1005cc <strstr+0x65>
  1005a0:	8b 55 08             	mov    0x8(%ebp),%edx
  1005a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1005a6:	01 d0                	add    %edx,%eax
  1005a8:	83 ec 04             	sub    $0x4,%esp
  1005ab:	ff 75 ec             	pushl  -0x14(%ebp)
  1005ae:	ff 75 0c             	pushl  0xc(%ebp)
  1005b1:	50                   	push   %eax
  1005b2:	e8 7d fd ff ff       	call   100334 <memcmp>
  1005b7:	83 c4 10             	add    $0x10,%esp
  1005ba:	85 c0                	test   %eax,%eax
  1005bc:	75 0a                	jne    1005c8 <strstr+0x61>
  1005be:	8b 55 08             	mov    0x8(%ebp),%edx
  1005c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1005c4:	01 d0                	add    %edx,%eax
  1005c6:	eb 14                	jmp    1005dc <strstr+0x75>
  1005c8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1005cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005cf:	2b 45 ec             	sub    -0x14(%ebp),%eax
  1005d2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  1005d5:	73 c9                	jae    1005a0 <strstr+0x39>
  1005d7:	b8 00 00 00 00       	mov    $0x0,%eax
  1005dc:	c9                   	leave  
  1005dd:	c3                   	ret    

001005de <strtok_r>:
  1005de:	55                   	push   %ebp
  1005df:	89 e5                	mov    %esp,%ebp
  1005e1:	83 ec 10             	sub    $0x10,%esp
  1005e4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1005e8:	75 27                	jne    100611 <strtok_r+0x33>
  1005ea:	8b 45 10             	mov    0x10(%ebp),%eax
  1005ed:	8b 00                	mov    (%eax),%eax
  1005ef:	89 45 08             	mov    %eax,0x8(%ebp)
  1005f2:	eb 1d                	jmp    100611 <strtok_r+0x33>
  1005f4:	8b 45 08             	mov    0x8(%ebp),%eax
  1005f7:	0f b6 00             	movzbl (%eax),%eax
  1005fa:	84 c0                	test   %al,%al
  1005fc:	75 0f                	jne    10060d <strtok_r+0x2f>
  1005fe:	8b 45 10             	mov    0x10(%ebp),%eax
  100601:	8b 55 08             	mov    0x8(%ebp),%edx
  100604:	89 10                	mov    %edx,(%eax)
  100606:	b8 00 00 00 00       	mov    $0x0,%eax
  10060b:	eb 6a                	jmp    100677 <strtok_r+0x99>
  10060d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  100611:	8b 45 08             	mov    0x8(%ebp),%eax
  100614:	0f b6 00             	movzbl (%eax),%eax
  100617:	0f be c0             	movsbl %al,%eax
  10061a:	50                   	push   %eax
  10061b:	ff 75 0c             	pushl  0xc(%ebp)
  10061e:	e8 0e fe ff ff       	call   100431 <strchr>
  100623:	83 c4 08             	add    $0x8,%esp
  100626:	85 c0                	test   %eax,%eax
  100628:	75 ca                	jne    1005f4 <strtok_r+0x16>
  10062a:	8b 45 08             	mov    0x8(%ebp),%eax
  10062d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100630:	eb 04                	jmp    100636 <strtok_r+0x58>
  100632:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  100636:	8b 45 08             	mov    0x8(%ebp),%eax
  100639:	0f b6 00             	movzbl (%eax),%eax
  10063c:	0f be c0             	movsbl %al,%eax
  10063f:	50                   	push   %eax
  100640:	ff 75 0c             	pushl  0xc(%ebp)
  100643:	e8 e9 fd ff ff       	call   100431 <strchr>
  100648:	83 c4 08             	add    $0x8,%esp
  10064b:	85 c0                	test   %eax,%eax
  10064d:	74 e3                	je     100632 <strtok_r+0x54>
  10064f:	8b 45 08             	mov    0x8(%ebp),%eax
  100652:	0f b6 00             	movzbl (%eax),%eax
  100655:	84 c0                	test   %al,%al
  100657:	74 13                	je     10066c <strtok_r+0x8e>
  100659:	8b 45 08             	mov    0x8(%ebp),%eax
  10065c:	c6 00 00             	movb   $0x0,(%eax)
  10065f:	8b 45 08             	mov    0x8(%ebp),%eax
  100662:	8d 50 01             	lea    0x1(%eax),%edx
  100665:	8b 45 10             	mov    0x10(%ebp),%eax
  100668:	89 10                	mov    %edx,(%eax)
  10066a:	eb 08                	jmp    100674 <strtok_r+0x96>
  10066c:	8b 45 10             	mov    0x10(%ebp),%eax
  10066f:	8b 55 08             	mov    0x8(%ebp),%edx
  100672:	89 10                	mov    %edx,(%eax)
  100674:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100677:	c9                   	leave  
  100678:	c3                   	ret    

00100679 <memset>:
  100679:	55                   	push   %ebp
  10067a:	89 e5                	mov    %esp,%ebp
  10067c:	83 ec 10             	sub    $0x10,%esp
  10067f:	8b 45 08             	mov    0x8(%ebp),%eax
  100682:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100685:	eb 0e                	jmp    100695 <memset+0x1c>
  100687:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10068a:	8d 50 01             	lea    0x1(%eax),%edx
  10068d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  100690:	8b 55 0c             	mov    0xc(%ebp),%edx
  100693:	88 10                	mov    %dl,(%eax)
  100695:	8b 45 10             	mov    0x10(%ebp),%eax
  100698:	8d 50 ff             	lea    -0x1(%eax),%edx
  10069b:	89 55 10             	mov    %edx,0x10(%ebp)
  10069e:	85 c0                	test   %eax,%eax
  1006a0:	75 e5                	jne    100687 <memset+0xe>
  1006a2:	8b 45 08             	mov    0x8(%ebp),%eax
  1006a5:	c9                   	leave  
  1006a6:	c3                   	ret    

001006a7 <strlen>:
  1006a7:	55                   	push   %ebp
  1006a8:	89 e5                	mov    %esp,%ebp
  1006aa:	83 ec 10             	sub    $0x10,%esp
  1006ad:	8b 45 08             	mov    0x8(%ebp),%eax
  1006b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1006b3:	eb 04                	jmp    1006b9 <strlen+0x12>
  1006b5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1006b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1006bc:	0f b6 00             	movzbl (%eax),%eax
  1006bf:	84 c0                	test   %al,%al
  1006c1:	75 f2                	jne    1006b5 <strlen+0xe>
  1006c3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1006c6:	8b 45 08             	mov    0x8(%ebp),%eax
  1006c9:	29 c2                	sub    %eax,%edx
  1006cb:	89 d0                	mov    %edx,%eax
  1006cd:	c9                   	leave  
  1006ce:	c3                   	ret    

001006cf <strnlen>:
  1006cf:	55                   	push   %ebp
  1006d0:	89 e5                	mov    %esp,%ebp
  1006d2:	83 ec 10             	sub    $0x10,%esp
  1006d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1006dc:	eb 04                	jmp    1006e2 <strnlen+0x13>
  1006de:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1006e2:	8b 55 08             	mov    0x8(%ebp),%edx
  1006e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1006e8:	01 d0                	add    %edx,%eax
  1006ea:	0f b6 00             	movzbl (%eax),%eax
  1006ed:	84 c0                	test   %al,%al
  1006ef:	74 08                	je     1006f9 <strnlen+0x2a>
  1006f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1006f4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  1006f7:	72 e5                	jb     1006de <strnlen+0xf>
  1006f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1006fc:	c9                   	leave  
  1006fd:	c3                   	ret    

001006fe <strlcpy>:
  1006fe:	55                   	push   %ebp
  1006ff:	89 e5                	mov    %esp,%ebp
  100701:	83 ec 10             	sub    $0x10,%esp
  100704:	ff 75 0c             	pushl  0xc(%ebp)
  100707:	e8 9b ff ff ff       	call   1006a7 <strlen>
  10070c:	83 c4 04             	add    $0x4,%esp
  10070f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100712:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  100716:	74 33                	je     10074b <strlcpy+0x4d>
  100718:	8b 45 10             	mov    0x10(%ebp),%eax
  10071b:	83 e8 01             	sub    $0x1,%eax
  10071e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100721:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100724:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100727:	73 06                	jae    10072f <strlcpy+0x31>
  100729:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10072c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10072f:	ff 75 fc             	pushl  -0x4(%ebp)
  100732:	ff 75 0c             	pushl  0xc(%ebp)
  100735:	ff 75 08             	pushl  0x8(%ebp)
  100738:	e8 45 fb ff ff       	call   100282 <memcpy>
  10073d:	83 c4 0c             	add    $0xc,%esp
  100740:	8b 55 08             	mov    0x8(%ebp),%edx
  100743:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100746:	01 d0                	add    %edx,%eax
  100748:	c6 00 00             	movb   $0x0,(%eax)
  10074b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10074e:	c9                   	leave  
  10074f:	c3                   	ret    

00100750 <strlcat>:
  100750:	55                   	push   %ebp
  100751:	89 e5                	mov    %esp,%ebp
  100753:	83 ec 10             	sub    $0x10,%esp
  100756:	ff 75 0c             	pushl  0xc(%ebp)
  100759:	e8 49 ff ff ff       	call   1006a7 <strlen>
  10075e:	83 c4 04             	add    $0x4,%esp
  100761:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100764:	ff 75 08             	pushl  0x8(%ebp)
  100767:	e8 3b ff ff ff       	call   1006a7 <strlen>
  10076c:	83 c4 04             	add    $0x4,%esp
  10076f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100772:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  100776:	74 49                	je     1007c1 <strlcat+0x71>
  100778:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10077b:	3b 45 10             	cmp    0x10(%ebp),%eax
  10077e:	73 41                	jae    1007c1 <strlcat+0x71>
  100780:	8b 45 10             	mov    0x10(%ebp),%eax
  100783:	2b 45 f4             	sub    -0xc(%ebp),%eax
  100786:	83 e8 01             	sub    $0x1,%eax
  100789:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10078c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10078f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100792:	73 06                	jae    10079a <strlcat+0x4a>
  100794:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100797:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10079a:	8b 55 08             	mov    0x8(%ebp),%edx
  10079d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007a0:	01 d0                	add    %edx,%eax
  1007a2:	ff 75 fc             	pushl  -0x4(%ebp)
  1007a5:	ff 75 0c             	pushl  0xc(%ebp)
  1007a8:	50                   	push   %eax
  1007a9:	e8 d4 fa ff ff       	call   100282 <memcpy>
  1007ae:	83 c4 0c             	add    $0xc,%esp
  1007b1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1007b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1007b7:	01 c2                	add    %eax,%edx
  1007b9:	8b 45 08             	mov    0x8(%ebp),%eax
  1007bc:	01 d0                	add    %edx,%eax
  1007be:	c6 00 00             	movb   $0x0,(%eax)
  1007c1:	8b 55 f8             	mov    -0x8(%ebp),%edx
  1007c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007c7:	01 d0                	add    %edx,%eax
  1007c9:	c9                   	leave  
  1007ca:	c3                   	ret    
