extern	int	MIN_2(int	x,	int	y);

int	 main()	{
		int	min_val;
		int i;
		int a[5] = {10,	20,	3,	4,	5};
		for(i = 0; i < 5; i++){
			if(i == 0){
				min_val = a[0];
			}else{ min_val = MIN_2(min_val, a[i]);}
		}
		printf("minValue is %d \n", min_val);
		return	min_val;
}
