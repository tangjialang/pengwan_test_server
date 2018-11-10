
--[[
  	CAT_MAX_HP	= 0,		// Ѫ������ 1
	CAT_MAX_MP,				// ְҵ���� 2
	CAT_ATC,				// ���� 3
	CAT_DEF,				// ���� 4
	CAT_HIT,				// ���� 5
	CAT_DUCK,				// ���� 6
	CAT_CRIT,				// ���� 7
	CAT_RESIST,				// �ֿ����� 8
	CAT_BLOCK,				// �� 9
	CAT_AB_ATC,				// ְҵ����1����ϵ���ԣ� 10
	CAT_AB_DEF,				// ְҵ����2����ϵ���ԣ� 11
	CAT_CritDam,			// ְҵ����3��ľϵ���ԣ�12
	CAT_MoveSpeed,			// �ƶ��ٶ�(Ԥ��) 13
	CAT_S_REDUCE,			// ���Լ���	      14
]]--

--5���⽱��extra_Award=
sctx_conf={

	checklv_conf={1,1,30,40,50,60,70,80,90}, --��صȼ�����


	--��ͨ81��(Award�������ֹ��һ���ܵĿ��Եõ���Щ����)
	[1]={
			[1]={Award={[3]=100,},},
			[2]={Award={[3]=100,[4]=100,},},
			[3]={Award={[1]=800,[3]=100,[4]=100,},},
			[4]={Award={[1]=800,[3]=100,[4]=100,[7]=100,},},
			[5]={Award={[1]=800,[3]=100,[4]=100,[5]=100,[7]=100,},},
			[6]={Award={[1]=800,[3]=100,[4]=100,[5]=100,[6]=100,[7]=100,},},
			[7]={Award={[1]=800,[3]=100,[4]=100,[5]=100,[6]=100,[7]=100,[8]=100},},
			[8]={Award={[1]=800,[3]=200,[4]=100,[5]=100,[6]=100,[7]=100,[8]=100},},
			[9]={Award={[1]=800,[3]=200,[4]=100,[5]=100,[6]=100,[7]=100,[8]=100,[9]=100,},},
			[10]={Award={[1]=800,[3]=300,[4]=100,[5]=100,[6]=100,[7]=100,[8]=100,[9]=100,},},
			[11]={Award={[1]=800,[3]=300,[4]=200,[5]=100,[6]=100,[7]=100,[8]=100,[9]=100,},},
			[12]={Award={[1]=1600,[3]=300,[4]=200,[5]=100,[6]=100,[7]=100,[8]=100,[9]=100,},},
			[13]={Award={[1]=1600,[3]=300,[4]=200,[5]=100,[6]=100,[7]=200,[8]=100,[9]=100,},},
			[14]={Award={[1]=1600,[3]=300,[4]=200,[5]=200,[6]=100,[7]=200,[8]=100,[9]=100,},},
			[15]={Award={[1]=1600,[3]=300,[4]=200,[5]=200,[6]=200,[7]=200,[8]=100,[9]=100,},},
			[16]={Award={[1]=1600,[3]=300,[4]=200,[5]=200,[6]=200,[7]=200,[8]=200,[9]=100,},},
			[17]={Award={[1]=1600,[3]=300,[4]=300,[5]=200,[6]=200,[7]=200,[8]=200,[9]=100,},},
			[18]={Award={[1]=1600,[3]=300,[4]=300,[5]=200,[6]=200,[7]=200,[8]=200,[9]=200,},},
			[19]={Award={[1]=1600,[3]=400,[4]=300,[5]=200,[6]=200,[7]=200,[8]=200,[9]=200,},},
			[20]={Award={[1]=1600,[3]=400,[4]=400,[5]=200,[6]=200,[7]=200,[8]=200,[9]=200,},},
			[21]={Award={[1]=2400,[3]=400,[4]=400,[5]=200,[6]=200,[7]=200,[8]=200,[9]=200,},},
			[22]={Award={[1]=2400,[3]=400,[4]=400,[5]=200,[6]=200,[7]=300,[8]=200,[9]=200,},},
			[23]={Award={[1]=2400,[3]=400,[4]=400,[5]=300,[6]=200,[7]=300,[8]=200,[9]=200,},},
			[24]={Award={[1]=2400,[3]=400,[4]=400,[5]=300,[6]=300,[7]=300,[8]=200,[9]=200,},},
			[25]={Award={[1]=2400,[3]=400,[4]=400,[5]=300,[6]=300,[7]=300,[8]=300,[9]=200,},},
			[26]={Award={[1]=2400,[3]=500,[4]=400,[5]=300,[6]=300,[7]=300,[8]=300,[9]=200,},},
			[27]={Award={[1]=2400,[3]=500,[4]=400,[5]=300,[6]=300,[7]=300,[8]=300,[9]=300,},},
			[28]={Award={[1]=2400,[3]=600,[4]=400,[5]=300,[6]=300,[7]=300,[8]=300,[9]=300,},},
			[29]={Award={[1]=2400,[3]=600,[4]=500,[5]=300,[6]=300,[7]=300,[8]=300,[9]=300,},},
			[30]={Award={[1]=3200,[3]=600,[4]=500,[5]=300,[6]=300,[7]=300,[8]=300,[9]=300,},},
			[31]={Award={[1]=3200,[3]=600,[4]=500,[5]=300,[6]=300,[7]=400,[8]=300,[9]=300,},},
			[32]={Award={[1]=3200,[3]=600,[4]=500,[5]=400,[6]=300,[7]=400,[8]=300,[9]=300,},},
			[33]={Award={[1]=3200,[3]=600,[4]=500,[5]=400,[6]=400,[7]=400,[8]=300,[9]=300,},},
			[34]={Award={[1]=3200,[3]=600,[4]=500,[5]=400,[6]=400,[7]=400,[8]=400,[9]=300,},},
			[35]={Award={[1]=3200,[3]=600,[4]=600,[5]=400,[6]=400,[7]=400,[8]=400,[9]=300,},},
			[36]={Award={[1]=3200,[3]=600,[4]=600,[5]=400,[6]=400,[7]=400,[8]=400,[9]=400,},},
			[37]={Award={[1]=3200,[3]=700,[4]=600,[5]=400,[6]=400,[7]=400,[8]=400,[9]=400,},},
			[38]={Award={[1]=3200,[3]=700,[4]=700,[5]=400,[6]=400,[7]=400,[8]=400,[9]=400,},},
			[39]={Award={[1]=4000,[3]=700,[4]=700,[5]=400,[6]=400,[7]=400,[8]=400,[9]=400,},},
			[40]={Award={[1]=4000,[3]=700,[4]=700,[5]=400,[6]=400,[7]=500,[8]=400,[9]=400,},},
			[41]={Award={[1]=4000,[3]=700,[4]=700,[5]=500,[6]=400,[7]=500,[8]=400,[9]=400,},},
			[42]={Award={[1]=4000,[3]=700,[4]=700,[5]=500,[6]=500,[7]=500,[8]=400,[9]=400,},},
			[43]={Award={[1]=4000,[3]=700,[4]=700,[5]=500,[6]=500,[7]=500,[8]=500,[9]=400,},},
			[44]={Award={[1]=4000,[3]=800,[4]=700,[5]=500,[6]=500,[7]=500,[8]=500,[9]=400,},},
			[45]={Award={[1]=4000,[3]=800,[4]=700,[5]=500,[6]=500,[7]=500,[8]=500,[9]=500,},},
			[46]={Award={[1]=4000,[3]=900,[4]=700,[5]=500,[6]=500,[7]=500,[8]=500,[9]=500,},},
			[47]={Award={[1]=4000,[3]=900,[4]=800,[5]=500,[6]=500,[7]=500,[8]=500,[9]=500,},},
			[48]={Award={[1]=4800,[3]=900,[4]=800,[5]=500,[6]=500,[7]=500,[8]=500,[9]=500,},},
			[49]={Award={[1]=4800,[3]=900,[4]=800,[5]=500,[6]=500,[7]=600,[8]=500,[9]=500,},},
			[50]={Award={[1]=4800,[3]=900,[4]=800,[5]=600,[6]=500,[7]=600,[8]=500,[9]=500,},},
			[51]={Award={[1]=4800,[3]=900,[4]=800,[5]=600,[6]=600,[7]=600,[8]=500,[9]=500,},},
			[52]={Award={[1]=4800,[3]=900,[4]=800,[5]=600,[6]=600,[7]=600,[8]=600,[9]=500,},},
			[53]={Award={[1]=4800,[3]=900,[4]=900,[5]=600,[6]=600,[7]=600,[8]=600,[9]=500,},},
			[54]={Award={[1]=4800,[3]=900,[4]=900,[5]=600,[6]=600,[7]=600,[8]=600,[9]=600,},},
			[55]={Award={[1]=4800,[3]=1000,[4]=900,[5]=600,[6]=600,[7]=600,[8]=600,[9]=600,},},
			[56]={Award={[1]=4800,[3]=1000,[4]=1000,[5]=600,[6]=600,[7]=600,[8]=600,[9]=600,},},
			[57]={Award={[1]=5600,[3]=1000,[4]=1000,[5]=600,[6]=600,[7]=600,[8]=600,[9]=600,},},
			[58]={Award={[1]=5600,[3]=1000,[4]=1000,[5]=600,[6]=600,[7]=700,[8]=600,[9]=600,},},
			[59]={Award={[1]=5600,[3]=1000,[4]=1000,[5]=700,[6]=600,[7]=700,[8]=600,[9]=600,},},
			[60]={Award={[1]=5600,[3]=1000,[4]=1000,[5]=700,[6]=700,[7]=700,[8]=600,[9]=600,},},
			[61]={Award={[1]=5600,[3]=1000,[4]=1000,[5]=700,[6]=700,[7]=700,[8]=700,[9]=600,},},
			[62]={Award={[1]=5600,[3]=1100,[4]=1000,[5]=700,[6]=700,[7]=700,[8]=700,[9]=600,},},
			[63]={Award={[1]=5600,[3]=1100,[4]=1000,[5]=700,[6]=700,[7]=700,[8]=700,[9]=700,},},
			[64]={Award={[1]=5600,[3]=1200,[4]=1000,[5]=700,[6]=700,[7]=700,[8]=700,[9]=700,},},
			[65]={Award={[1]=5600,[3]=1200,[4]=1100,[5]=700,[6]=700,[7]=700,[8]=700,[9]=700,},},
			[66]={Award={[1]=6400,[3]=1200,[4]=1100,[5]=700,[6]=700,[7]=700,[8]=700,[9]=700,},},
			[67]={Award={[1]=6400,[3]=1200,[4]=1100,[5]=700,[6]=700,[7]=800,[8]=700,[9]=700,},},
			[68]={Award={[1]=6400,[3]=1200,[4]=1100,[5]=800,[6]=700,[7]=800,[8]=700,[9]=700,},},
			[69]={Award={[1]=6400,[3]=1200,[4]=1100,[5]=800,[6]=800,[7]=800,[8]=700,[9]=700,},},
			[70]={Award={[1]=6400,[3]=1200,[4]=1100,[5]=800,[6]=800,[7]=800,[8]=800,[9]=700,},},
			[71]={Award={[1]=6400,[3]=1200,[4]=1200,[5]=800,[6]=800,[7]=800,[8]=800,[9]=700,},},
			[72]={Award={[1]=6400,[3]=1200,[4]=1200,[5]=800,[6]=800,[7]=800,[8]=800,[9]=800,},},
			[73]={Award={[1]=6400,[3]=1300,[4]=1200,[5]=800,[6]=800,[7]=800,[8]=800,[9]=800,},},
			[74]={Award={[1]=6400,[3]=1300,[4]=1300,[5]=800,[6]=800,[7]=800,[8]=800,[9]=800,},},
			[75]={Award={[1]=7200,[3]=1300,[4]=1300,[5]=800,[6]=800,[7]=800,[8]=800,[9]=800,},},
			[76]={Award={[1]=7200,[3]=1300,[4]=1300,[5]=800,[6]=800,[7]=900,[8]=800,[9]=800,},},
			[77]={Award={[1]=7200,[3]=1300,[4]=1300,[5]=900,[6]=800,[7]=900,[8]=800,[9]=800,},},
			[78]={Award={[1]=7200,[3]=1300,[4]=1300,[5]=900,[6]=900,[7]=900,[8]=800,[9]=800,},},
			[79]={Award={[1]=7200,[3]=1300,[4]=1300,[5]=900,[6]=900,[7]=900,[8]=900,[9]=800,},},
			[80]={Award={[1]=7200,[3]=1400,[4]=1300,[5]=900,[6]=900,[7]=900,[8]=900,[9]=800,},},
			[81]={Award={[1]=7200,[3]=1400,[4]=1300,[5]=900,[6]=900,[7]=900,[8]=900,[9]=900,},},
		},
	--Ӣ��16��
	[2]={
			[1]={Award={[3]=300,[5]=200,},},
			[2]={Award={[3]=300,[4]=300,[5]=200,[6]=200,},},
			[3]={Award={[1]=2000,[3]=300,[4]=300,[5]=200,[6]=200,[8]=200,},},
			[4]={Award={[1]=2000,[3]=300,[4]=300,[5]=200,[6]=200,[7]=200,[8]=200,[9]=200,},},
			[5]={Award={[1]=2000,[3]=600,[4]=300,[5]=400,[6]=200,[7]=200,[8]=200,[9]=200,},},
			[6]={Award={[1]=2000,[3]=600,[4]=600,[5]=400,[6]=400,[7]=200,[8]=200,[9]=200,},},
			[7]={Award={[1]=4000,[3]=600,[4]=600,[5]=400,[6]=400,[7]=200,[8]=400,[9]=200,},},
			[8]={Award={[1]=4000,[3]=600,[4]=600,[5]=400,[6]=400,[7]=400,[8]=400,[9]=400,},},
			[9]={Award={[1]=4000,[3]=900,[4]=600,[5]=600,[6]=400,[7]=400,[8]=400,[9]=400,},},
			[10]={Award={[1]=4000,[3]=900,[4]=900,[5]=600,[6]=600,[7]=400,[8]=400,[9]=400,},},
			[11]={Award={[1]=6000,[3]=900,[4]=900,[5]=600,[6]=600,[7]=400,[8]=600,[9]=400,},},
			[12]={Award={[1]=6000,[3]=900,[4]=900,[5]=600,[6]=600,[7]=600,[8]=600,[9]=600,},},
			[13]={Award={[1]=6000,[3]=1200,[4]=900,[5]=800,[6]=600,[7]=600,[8]=600,[9]=600,},},
			[14]={Award={[1]=6000,[3]=1200,[4]=1200,[5]=800,[6]=800,[7]=600,[8]=600,[9]=600,},},
			[15]={Award={[1]=8000,[3]=1200,[4]=1200,[5]=800,[6]=800,[7]=600,[8]=800,[9]=600,},},
			[16]={Award={[1]=8000,[3]=1200,[4]=1200,[5]=800,[6]=800,[7]=800,[8]=800,[9]=800,},},
		},
}


