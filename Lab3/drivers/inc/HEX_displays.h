#ifndef	__HEX_DISPLAYS
#define	__HEX_DISPLAYS

	typedef	enum	{
		HEX0	=	0X00000001,
		HEX1	=	0X00000002,
		HEX2	=	0X00000004,
		HEX3	=	0X00000008,
		HEX4	=	0X00000010,
		HEX5	=	0X00000020,
	}	HEX_t;
	
	extern	void	HEX_clear_ASM(HEX_t	hex);
	extern	void	HEX_flood_ASM(HEX_t	hex);
	extern	void	HEX_write_ASM(HEX_t	hex,	char	val);

#endif