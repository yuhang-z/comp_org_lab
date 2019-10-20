int	main(){
		int	a[5]	=	{1,	20,	3,	4,	5};
		int	min_val;
		int i;
		for(i = 0; i < 5; i++){
			if(i == 0){
				min_val = a[0];
			}else if(min_val > a[i]){
				min_val = a[i];
			} 
		}
		printf("min_vale is %d \n", min_val);
		return	min_val;
}
