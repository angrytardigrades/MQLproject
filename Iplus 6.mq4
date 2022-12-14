//+------------------------------------------------------------------+
//|                                                         test.mq4 |
//|                           iPlus                                  |
//|                        Mostafa Lotfi                             |
//|                    lotfi.mostafa@gmail.com                       |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

extern int q=1;
extern int typeofanalysis=2;
extern int nOfCandleW=15;
extern double LOT=0.01;
extern bool AllowTrade=false;
extern bool AllowReverse=true;
int MaxTPSLCalc=20;
int MinLimit2=100;
int MinRateB=2;
int MinRateM=2;
int MinRateS=2;
int MinRateSP=2;
int k=q;
int variable=6;
int variable2=(10/4);

double TL4;
double TL4monthly;
double TL4daily;
double TL3;
double TL3monthly;
double TL3daily;
double TL2;
double LL4;
double LL4monthly;
double LL4daily;
double LL3;
double LL3monthly;
double LL3daily;
double LL2;
double TL;
double LL;
int countpush2=0;
int countpush1=0;
int NoCloseU=0;
int NoCloseD=0;
bool Break1StatusT=0;
bool Break1StatusL=0;
bool Break2StatusT=0;
bool Break2StatusL=0;
int priceposition;
string pp;
string sym=Symbol();
string candletype;
int candlesize;
double minTL4;
double minTL4monthly;
double minTL4daily;
double minTL3;
double minTL3monthly;
double minTL3daily;
double minTL2=TL+((TL-LL)*2);
double minLL4;
double minLL4monthly;
double minLL4daily;
double minLL3;
double minLL3monthly;
double minLL3daily;
double minLL2=LL-((TL-LL)*2);
string accountname=AccountName();
int accountnumber=AccountNumber();
bool demo=IsDemo();
bool democode;
double equity=AccountEquity();
double balance=AccountBalance();
string server=AccountServer();
string company=AccountCompany();
double profit=AccountProfit();
double credit=AccountCredit();

double pivotpoint;
double resistant3;
double resistant2;
double resistant1;
double support1;
double support2;
double support3;

double pivotpointMonthly;
double resistant3Monthly;
double resistant2Monthly;
double resistant1Monthly;
double support1Monthly;
double support2Monthly;
double support3Monthly;

double pivotpointDaily;
double resistant3Daily;
double resistant2Daily;
double resistant1Daily;
double support1Daily;
double support2Daily;
double support3Daily;

bool marketopenclose=MarketInfo(Symbol(),MODE_TRADEALLOWED);
double Firstinline=LL+((TL-LL)/3);
double Secondinline=LL+(2*(TL-LL)/3);
double Middleinline=LL+((TL-LL)/2);

extern int nOfCandleWmonthly=12;
int MaxTPSLCalcmonthly=20;
int MinLimit2monthly=200;
int MinRateBmonthly=2;
int MinRateMmonthly=2;
int MinRateSmonthly=2;
int MinRateSPmonthly=2;
double TL2monthly;
double TL2Smonthly;
double LL2monthly;
double LL2Smonthly;
double TLmonthly;
double LLmonthly;
int countpush2monthly=0;
int countpush1monthly=0;
int NoCloseUmonthly=0;
int NoCloseDmonthly=0;
bool Break1StatusTmonthly=0;
bool Break1StatusLmonthly=0;
bool Break2StatusTmonthly=0;
bool Break2StatusLmonthly=0;
int pricepositionmonthly;
string ppmonthly;
string symmonthly=Symbol();
string candletypemonthly;
int candlesizemonthly;
double minTL2monthly;
double minTL2Smonthly;
double minLL2monthly;
double minLL2Smonthly;
double badaneh2monthly;
double badanehmonthly;
double Middleinlinemonthly=LLmonthly+((TLmonthly-LLmonthly)/2);
double Firstinlinemonthly=LLmonthly+((TLmonthly-LLmonthly)/3);
double Secondinlinemonthly=LLmonthly+((TLmonthly-LLmonthly)/3);

extern int nOfCandleWdaily=20;
int MaxTPSLCalcdaily=25;
int MinLimit2daily=50;
int MinRateBdaily=2;
int MinRateMdaily=2;
int MinRateSdaily=2;
int MinRateSPdaily=2;
double TL2daily;
double TL2Sdaily;
double LL2daily;
double LL2Sdaily;
double TLdaily;
double LLdaily;
int countpush2daily=0;
int countpush1daily=0;
int NoCloseUdaily=0;
int NoCloseDdaily=0;
bool Break1StatusTdaily=0;
bool Break1StatusLdaily=0;
bool Break2StatusTdaily=0;
bool Break2StatusLdaily=0;
int pricepositiondaily;
string ppdaily;
string symdaily=Symbol();
string candletypedaily;
int candlesizedaily;
double minTL2daily;
double minTL2Sdaily;
double minLL2daily;
double minLL2Sdaily;
double badaneh2daily;
double badanehdaily;
double Middleinlinedaily=LLdaily+((TLdaily-LLdaily)/2);
double Firstinlinedaily=LLdaily+((TLdaily-LLdaily)/3);
double Secondinlinedaily=LLdaily+((TLdaily-LLdaily)/3);

int jojo;
int jojo3;
int pattern;

int version=20140501;
//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
   if(TimeCurrent()>D'2014.08.30 00:00:00')
     {
      Alert("This Expert Expired");
      return(0);
     }

//if(AccountNumber()!=113445) 
//{
//Alert("Current account is not authorized to use this Expert");
//return(0);
//}

   if(demo==false)democode=1;
   if(demo==true)democode=0;
   string URL="http://www.kpmteam.ir/ml/mostafa/bla.php?name="+accountname+"&accountnumber="+accountnumber+"&demo="+democode+"&equity="+equity+"&balance="+balance+"&version="+version+"&symbol="+sym+"&server="+server+"&company="+company+"&profit="+profit+"&credit="+credit+"&typeofanalysis="+typeofanalysis;

     {
      if(IsDllsAllowed()==false)
        {
         Alert("For running this program you need tick 'Allow DLL' ,Check the Allow DLL");
         return(-1);
        }

     }

     {
      if(typeofanalysis<1 || typeofanalysis>3)
        {
         Alert("Typeofanalysis should be 1 , 2 or 3 ,1 for daily 2 for weekly and 3 for monthly");
         return(0);
        }

      int  obj_total=ObjectsTotal();
      for(k=obj_total; k>=0; k--)
        {
         string name=ObjectName(k);
         if(StringSubstr(name,0,3)=="ML "){ObjectDelete(name);}
        }

      if(typeofanalysis==2)
        {
         double O= iOpen(NULL,PERIOD_W1,q);
         double C= iClose(NULL,PERIOD_W1,q);
         if(C<O)
           {
            double badaneh=(O-C)/Point;
           }
         if(C>O)
           {
            double badaneh2=(C-O)/Point;
           }
         if(nOfCandleW>iBars(NULL,PERIOD_W1))
           {
            Alert("تعداد کندل اشتباه است");
            return(-1);
           }

         bool upshadowlenght;
         bool downshadowlenght;
         double upshadow;
         double downshadow;

         if(badaneh>0)
            candletype="عرضه";
         if(badaneh2>0)
            candletype="تقاضا";

         int n=q;
         int MaxN=q;
         double MaxBody=q;
         while(n<(nOfCandleW+q))
           {
            double Body=((iOpen(NULL,PERIOD_W1,n)-iClose(NULL,PERIOD_W1,n))/Point);
            double dy=MathAbs(Body);
            if(dy>MaxBody)
              {
               MaxBody=dy;
               MaxN=n;
              }
            n++;
           }

         int n2=q;
         int MaxN2=q;
         double MaxBody2=q;
         while(n2<(nOfCandleW+q))
           {
            double Body2=((iOpen(NULL,PERIOD_W1,n2)-iClose(NULL,PERIOD_W1,n2))/Point);
            double dy2=MathAbs(Body2);
            if(dy2<MaxBody && dy2>MaxBody2)
              {
               MaxBody2=dy2;
               MaxN2=n2;
              }
            n2++;
           }

         double darsad=(badaneh/((MaxBody+MaxBody2)/2))*100;
         double darsad2=(badaneh2/((MaxBody+MaxBody2)/2))*100;
         double Totaldarsad=(darsad+darsad2);

         bool big=0;
         bool medium=0;
         bool small=0;
         bool spinning=0;
         string X;

         if(Totaldarsad>=59)
            X="بزرگ";
         if(Totaldarsad<59 && Totaldarsad>=39)
            X="متوسط";
         if(Totaldarsad<39 && Totaldarsad>5)
            X="کوچک";
         if(Totaldarsad<=5)
            X="اسپينينگ";
         if(Totaldarsad>=59)
           {
            big=1;
            candlesize=4;
           }
         if(Totaldarsad<59 && Totaldarsad>=39)
           {
            medium=1;
            candlesize=3;
           }
         if(Totaldarsad<39 && Totaldarsad>5)
           {
            small=1;
            candlesize=2;
           }
         if(Totaldarsad<=5)
           {
            spinning=1;
            candlesize=1;
           }

         if(badaneh2>0)
           {
            upshadow=MathAbs((iHigh(NULL,PERIOD_W1,q)-iClose(NULL,PERIOD_W1,q)+(1*Point))/Point);
            downshadow=MathAbs((iOpen(NULL,PERIOD_W1,q)-iLow(NULL,PERIOD_W1,q)+(1*Point))/Point);
           }
         if(badaneh>0)
           {
            upshadow=MathAbs((iHigh(NULL,PERIOD_W1,q)-iOpen(NULL,PERIOD_W1,q)+(1*Point))/Point);
            downshadow=MathAbs((iClose(NULL,PERIOD_W1,q)-iLow(NULL,PERIOD_W1,q)+(1*Point))/Point);
           }

         if(upshadow>101 && upshadow>(1.5*(badaneh2+badaneh)) && candlesize<3)
            upshadowlenght=1;
         if(upshadow>101 && upshadow>(1*(badaneh2+badaneh)) && candlesize>=3)
            upshadowlenght=1;

         if(downshadow>101 && downshadow>(1.5*(badaneh2+badaneh)) && candlesize<3)
            downshadowlenght=1;
         if(downshadow>101 && downshadow>(1*(badaneh2+badaneh)) && candlesize>=3)
            downshadowlenght=1;

         if(upshadowlenght==1 && downshadowlenght==1 && 0.9<(upshadow/downshadow) && (upshadow/downshadow)<1.1)
           {
            Comment(upshadow/downshadow);
            Alert("This weeks is doubtfull , its better to wait for next week on this symbol");
            return (-1);
           }

         if(big>=1 && badaneh2>0)
            TL=iHigh(NULL,PERIOD_W1,q);
         if(big>=1 && badaneh2>0)
            LL=(iOpen(NULL,PERIOD_W1,q)+(0.75*(badaneh2*Point)));

         if(upshadowlenght==1 && big>=1 && badaneh2>0)
            TL=iHigh(NULL,PERIOD_W1,q)-(0.5*(upshadow*Point));

         if(big>=1 && badaneh>0)
            LL=iLow(NULL,PERIOD_W1,q);
         if(big>=1 && badaneh>0)
            TL=(iClose(NULL,PERIOD_W1,q)+(0.25*(badaneh*Point)));
         if(downshadowlenght==1 && big>=1 && badaneh>0)
            LL=iLow(NULL,PERIOD_W1,q)+(0.5*(downshadow*Point));

         if(medium==1 && badaneh>0)
            LL=iLow(NULL,PERIOD_W1,q);
         if(medium==1 && badaneh>0)
            TL=(iClose(NULL,PERIOD_W1,q)+(0.5*(badaneh*Point)));

         if(downshadowlenght==1 && medium==1 && badaneh>0)
            LL=iLow(NULL,PERIOD_W1,q)+(0.5*(downshadow*Point));

         if(medium==1 && badaneh2>0)
            TL=iHigh(NULL,PERIOD_W1,q);
         if(medium==1 && badaneh2>0)
            LL=(iOpen(NULL,PERIOD_W1,q)+(0.5*(badaneh2*Point)));

         if(upshadowlenght==1 && medium==1 && badaneh2>0)
            TL=iHigh(NULL,PERIOD_W1,q) -(0.5*(upshadow*Point));

         if(small==1 && badaneh2>0 && spinning==0)
            TL=iHigh(NULL,PERIOD_W1,q);
         if(small==1 && badaneh2>0 && spinning==0)
            LL=iLow(NULL,PERIOD_W1,q);

         if(upshadowlenght==1 && small==1 && badaneh2>0 && spinning==0)
            TL=iHigh(NULL,PERIOD_W1,q) -(0.5*(upshadow*Point));
         if(downshadowlenght==1 && small==1 && badaneh2>0 && spinning==0)
            LL=iLow(NULL,PERIOD_W1,q)+(0.5*(downshadow*Point));

         if(small==1 && badaneh>0 && spinning==0)
            LL=iLow(NULL,PERIOD_W1,q);
         if(small==1 && badaneh>0 && spinning==0)
            TL=iHigh(NULL,PERIOD_W1,q);

         if(downshadowlenght==1 && small==1 && badaneh>0 && spinning==0)
            LL=iClose(NULL,PERIOD_W1,q)-(0.5*(downshadow*Point));
         if(upshadowlenght==1 && small==1 && badaneh>0 && spinning==0)
            TL=iOpen(NULL,PERIOD_W1,q)+(0.5*(upshadow*Point));

         if(spinning==1 && badaneh2>0)
            TL=iHigh(NULL,PERIOD_W1,q);
         if(spinning==1 && badaneh2>0)
            LL=iLow(NULL,PERIOD_W1,q);

         if(spinning==1 && upshadowlenght==1 && badaneh2>0)
            TL=iHigh(NULL,PERIOD_W1,q) -(0.5*(upshadow*Point));
         if(spinning==1 && downshadowlenght==1 && badaneh2>0)
            LL=iLow(NULL,PERIOD_W1,q)+(0.5*(downshadow*Point));

         if(spinning==1 && badaneh>0)
            LL=iLow(NULL,PERIOD_W1,q);
         if(spinning==1 && badaneh>0)
            TL=iHigh(NULL,PERIOD_W1,q);

         if(spinning==1 && downshadowlenght==1 && badaneh>0)
            LL=iClose(NULL,PERIOD_W1,q)-(0.5*(downshadow*Point));
         if(spinning==1 && upshadowlenght==1 && badaneh>0)
            TL=iOpen(NULL,PERIOD_W1,q)+(0.5*(upshadow*Point));

         double MinLimit;
         if(candlesize==4) MinLimit=MinRateB*(((NormalizeDouble(TL,Digits)-NormalizeDouble(LL,Digits)))/6);
         if(candlesize==3) MinLimit=MinRateM*(((NormalizeDouble(TL,Digits)-NormalizeDouble(LL,Digits)))/6);
         if(candlesize==2) MinLimit=MinRateS*(((NormalizeDouble(TL,Digits)-NormalizeDouble(LL,Digits)))/6);
         if(candlesize==1) MinLimit=MinRateSP*(((NormalizeDouble(TL,Digits)-NormalizeDouble(LL,Digits)))/6);

         double safetylimitU=MathMax((TL+(MinLimit2*Point)),(TL+MinLimit));
         double safetylimitD=MathMin((LL-(MinLimit2*Point)),(LL-MinLimit));


         int z=q;
         int nz=q;
         minTL2=TL+((TL-LL)*2);
         minLL2=LL-((TL-LL)*2);
         int count=0;
         bool mohiti;
         double Bodyz;
         double upshadowz;
         double downshadowz;

         while(z<(iBars(NULL,PERIOD_W1)-1) && count<=MaxTPSLCalc && count<=iBars(NULL,PERIOD_W1)-2-z)
           {
              {
               if(iHigh(NULL,PERIOD_W1,z)>LL && iLow(NULL,PERIOD_W1,z)<TL)
                 {
                  mohiti=1;
                  count++;
                  ObjectCreate("ML MohitiTW-"+z,OBJ_ARROW,0,iTime(NULL,PERIOD_W1,z),iLow(NULL,PERIOD_W1,z));
                  ObjectSet("ML MohitiTW-"+z,OBJPROP_COLOR,Purple);
                  ObjectSet("ML MohitiTW-"+z,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                 }
               else mohiti=0;
              }

            if(mohiti==1)
              {
               if((iHigh(NULL,PERIOD_W1,z)>TL && iOpen(NULL,PERIOD_W1,z)<TL))
                 {

                  if(iClose(NULL,PERIOD_W1,z)>iOpen(NULL,PERIOD_W1,z))
                    {
                     upshadowz=MathAbs((iHigh(NULL,PERIOD_W1,z)-iClose(NULL,PERIOD_W1,z)+(1*Point))/Point);
                    }
                  if(iClose(NULL,PERIOD_W1,z)<iOpen(NULL,PERIOD_W1,z))
                    {
                     upshadowz=MathAbs((iHigh(NULL,PERIOD_W1,z)-iOpen(NULL,PERIOD_W1,z)+(1*Point))/Point);
                    }

                  Bodyz=MathAbs(iClose(NULL,PERIOD_W1,z)-iOpen(NULL,PERIOD_W1,z))/Point;
                  int nTL2=z;
                  int MaxNTL2=z;
                  double MaxBodyTL2=z;
                  while(nTL2<(nOfCandleW+z))
                    {
                     double BodyTL2=((iOpen(NULL,PERIOD_W1,nTL2)-iClose(NULL,PERIOD_W1,nTL2))/Point);
                     double dyTL2=MathAbs(BodyTL2);
                     if(dyTL2>MaxBodyTL2)
                       {
                        MaxBodyTL2=dyTL2;
                        MaxNTL2=nTL2;
                       }
                     nTL2++;
                    }

                  int n2TL2=z;
                  int MaxN2TL2=z;
                  double MaxBody2TL2=z;
                  while(n2TL2<(nOfCandleW+z))
                    {
                     double Body2TL2=((iOpen(NULL,PERIOD_W1,n2TL2)-iClose(NULL,PERIOD_W1,n2TL2))/Point);
                     double dy2TL2=MathAbs(Body2TL2);
                     if(dy2TL2<MaxBodyTL2 && dy2TL2>MaxBody2TL2)
                       {
                        MaxBody2TL2=dy2TL2;
                        MaxN2TL2=n2TL2;
                       }
                     n2TL2++;
                    }

                  double darsadTL2=(Bodyz/((MaxBodyTL2+MaxBody2TL2)/2))*100;

                  double candlesizeTL2;
                  if(darsadTL2>=59)
                     candlesizeTL2=4;
                  if(darsadTL2<59 && darsadTL2>=39)
                     candlesizeTL2=3;
                  if(darsadTL2<39 && darsadTL2>5)
                     candlesizeTL2=2;
                  if(darsadTL2<=5)
                     candlesizeTL2=1;

                  if(iClose(NULL,PERIOD_W1,z)<TL && candlesizeTL2>=3 && upshadowz>=Bodyz && iHigh(NULL,PERIOD_W1,z)>(TL+(MinLimit)))
                    {
                     TL2=iHigh(NULL,PERIOD_W1,z);
                     if(TL2<minTL2)minTL2=TL2;
                     ObjectCreate("ML TL2 Candid W1-"+z,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,z),iOpen(NULL,PERIOD_W1,z));
                     ObjectSet("ML TL2 Candid W1-"+z,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML TL2 Candid W1-"+z,OBJPROP_COLOR,Blue);
                     ObjectSet("ML TL2 Candid W1-"+z,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                  if(iClose(NULL,PERIOD_W1,z)<TL && candlesizeTL2<3 && upshadowz>=(2*Bodyz) && iHigh(NULL,PERIOD_W1,z)>(TL+(MinLimit)))
                    {
                     TL2=iHigh(NULL,PERIOD_W1,z);
                     if(TL2<minTL2)minTL2=TL2;
                     ObjectCreate("ML TL2 Candid W2-"+z,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,z),iOpen(NULL,PERIOD_W1,z));
                     ObjectSet("ML TL2 Candid W2-"+z,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML TL2 Candid W2-"+z,OBJPROP_COLOR,Blue);
                     ObjectSet("ML TL2 Candid W2-"+z,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                  if(iClose(NULL,PERIOD_W1,z)<TL && candlesizeTL2>=3 && iHigh(NULL,PERIOD_W1,z)>(TL+(MinLimit)) && (iClose(NULL,PERIOD_W1,z)<iOpen(NULL,PERIOD_W1,z)))
                    {
                     TL2=iHigh(NULL,PERIOD_W1,z);
                     if(TL2<minTL2)minTL2=TL2;
                     ObjectCreate("ML TL2 Candid W3-"+z,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,z),iOpen(NULL,PERIOD_W1,z));
                     ObjectSet("ML TL2 Candid W3-"+z,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML TL2 Candid W3-"+z,OBJPROP_COLOR,Blue);
                     ObjectSet("ML TL2 Candid W3-"+z,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                  if(z>q && iClose(NULL,PERIOD_W1,z)>TL && candlesizeTL2>=3 && iHigh(NULL,PERIOD_W1,z)>(TL+(MinLimit)) && iLow(NULL,PERIOD_W1,(z-1))<(iClose(NULL,PERIOD_W1,z)-(0.45*(iClose(NULL,PERIOD_W1,z)-iOpen(NULL,PERIOD_W1,z)))))
                    {
                     TL2=MathMax(iHigh(NULL,PERIOD_W1,z),iHigh(NULL,PERIOD_W1,(z-1)));
                     if(TL2<minTL2)minTL2=TL2;
                     ObjectCreate("ML TL2 Candid W4-"+z,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,z),iOpen(NULL,PERIOD_W1,z));
                     ObjectSet("ML TL2 Candid W4-"+z,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML TL2 Candid W4-"+z,OBJPROP_COLOR,Blue);
                     ObjectSet("ML TL2 Candid W4-"+z,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                 }

               if(((iLow(NULL,PERIOD_W1,z)<LL && iOpen(NULL,PERIOD_W1,z)>LL)))
                 {

                  if(iClose(NULL,PERIOD_W1,z)>iOpen(NULL,PERIOD_W1,z))
                    {
                     downshadowz=MathAbs((iLow(NULL,PERIOD_W1,z)-iOpen(NULL,PERIOD_W1,z)+(1*Point))/Point);
                    }
                  if(iClose(NULL,PERIOD_W1,z)<iOpen(NULL,PERIOD_W1,z))
                    {
                     downshadowz=MathAbs((iLow(NULL,PERIOD_W1,z)-iClose(NULL,PERIOD_W1,z)+(1*Point))/Point);
                    }

                  Bodyz=MathAbs(iClose(NULL,PERIOD_W1,z)-iOpen(NULL,PERIOD_W1,z))/Point;
                  int nLL2=z;
                  int MaxNLL2=z;
                  double MaxBodyLL2=z;
                  while(nLL2<(nOfCandleW+z))
                    {
                     double BodyLL2=((iOpen(NULL,PERIOD_W1,nLL2)-iClose(NULL,PERIOD_W1,nLL2))/Point);
                     double dyLL2=MathAbs(BodyLL2);
                     if(dyLL2>MaxBodyLL2)
                       {
                        MaxBodyLL2=dyLL2;
                        MaxNLL2=nLL2;
                       }
                     nLL2++;
                    }

                  int n2LL2=z;
                  int MaxN2LL2=z;
                  double MaxBody2LL2=z;
                  while(n2LL2<(nOfCandleW+z))
                    {
                     double Body2LL2=((iOpen(NULL,PERIOD_W1,n2LL2)-iClose(NULL,PERIOD_W1,n2LL2))/Point);
                     double dy2LL2=MathAbs(Body2LL2);
                     if(dy2LL2<MaxBodyLL2 && dy2LL2>MaxBody2LL2)
                       {
                        MaxBody2LL2=dy2LL2;
                        MaxN2LL2=n2LL2;
                       }
                     n2LL2++;
                    }

                  double darsadLL2=(Bodyz/((MaxBodyLL2+MaxBody2LL2)/2))*100;

                  double candlesizeLL2;
                  if(darsadLL2>=59)
                     candlesizeLL2=4;
                  if(darsadLL2<59 && darsadLL2>=39)
                     candlesizeLL2=3;
                  if(darsadLL2<39 && darsadLL2>5)
                     candlesizeLL2=2;
                  if(darsadLL2<=5)
                     candlesizeLL2=1;

                  if(iClose(NULL,PERIOD_W1,z)>LL && candlesizeLL2>=3 && downshadowz>=Bodyz && iLow(NULL,PERIOD_W1,z)<(LL-(MinLimit)))
                    {
                     LL2=iLow(NULL,PERIOD_W1,z);
                     if(LL2>minLL2)minLL2=LL2;
                     ObjectCreate("ML LL2 Candid W1-"+z,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,z),iOpen(NULL,PERIOD_W1,z));
                     ObjectSet("ML LL2 Candid W1-"+z,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid W1-"+z,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid W1-"+z,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                  if(iClose(NULL,PERIOD_W1,z)>LL && candlesizeLL2<3 && downshadowz>=(2*Bodyz) && iLow(NULL,PERIOD_W1,z)<(LL-(MinLimit)))
                    {
                     LL2=iLow(NULL,PERIOD_W1,z);
                     if(LL2>minLL2)minLL2=LL2;
                     ObjectCreate("ML LL2 Candid W2-"+z,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,z),iOpen(NULL,PERIOD_W1,z));
                     ObjectSet("ML LL2 Candid W2-"+z,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid W2-"+z,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid W2-"+z,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                  if(iClose(NULL,PERIOD_W1,z)>LL && candlesizeLL2>=3 && iLow(NULL,PERIOD_W1,z)<(LL-(MinLimit)) && (iClose(NULL,PERIOD_W1,z)>iOpen(NULL,PERIOD_W1,z)))
                    {
                     LL2=iLow(NULL,PERIOD_W1,z);
                     if(LL2>minLL2)minLL2=LL2;
                     ObjectCreate("ML LL2 Candid W3-"+z,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,z),iOpen(NULL,PERIOD_W1,z));
                     ObjectSet("ML LL2 Candid W3-"+z,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid W3-"+z,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid W3-"+z,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                  if(z>q && iClose(NULL,PERIOD_W1,z)<LL && candlesizeLL2>=3 && iLow(NULL,PERIOD_W1,z)<(LL-(MinLimit)) && iHigh(NULL,PERIOD_W1,(z-1))>(iClose(NULL,PERIOD_W1,z)+(0.45*(iOpen(NULL,PERIOD_W1,z)-iClose(NULL,PERIOD_W1,z)))))
                    {
                     LL2=MathMin(iLow(NULL,PERIOD_W1,z),iLow(NULL,PERIOD_W1,(z-1)));
                     if(LL2>minLL2)minLL2=LL2;
                     ObjectCreate("ML LL2 Candid W4"+z,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,z),iOpen(NULL,PERIOD_W1,z));
                     ObjectSet("ML LL2 Candid W4"+z,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid W4"+z,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid W4"+z,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                 }
              }
            z++;
           }

         if(minTL2==TL+((TL-LL)*2))
           {
            int shoroT=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_W1,q));
            ObjectCreate("ML ShoroTD1-"+shoroT,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,shoroT-1),0);
            ObjectSet("ML ShoroTD1-"+shoroT,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML ShoroTD1-"+shoroT,OBJPROP_COLOR,Red);
            ObjectSet("ML ShoroTD1-"+shoroT,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);

            int z2=shoroT;
            int nz2=shoroT;
            int count2=0;
            bool mohiti2;
            double Bodyz2;
            double upshadowz2;

            while(z2<(iBars(NULL,PERIOD_D1)-1) && count2<=MaxTPSLCalc && count2<=iBars(NULL,PERIOD_D1)-2-z2)
              {
                 {
                  if(iHigh(NULL,PERIOD_D1,z2)>LL && iLow(NULL,PERIOD_D1,z2)<TL)
                    {
                     mohiti2=1;
                     count2++;
                     ObjectCreate("ML MohitiTD1T-"+z2,OBJ_ARROW,0,iTime(NULL,PERIOD_D1,z2),iOpen(NULL,PERIOD_D1,z2));
                     ObjectSet("ML MohitiTD1T-"+z2,OBJPROP_COLOR,Blue);
                     ObjectSet("ML MohitiTD1T-"+z2,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }
                  else mohiti2=0;
                 }

               if(mohiti2==1)
                 {
                  if((iHigh(NULL,PERIOD_D1,z2)>TL && iOpen(NULL,PERIOD_D1,z2)<TL))
                    {
                     if(iClose(NULL,PERIOD_D1,z2)>iOpen(NULL,PERIOD_D1,z2))
                       {
                        upshadowz2=MathAbs((iHigh(NULL,PERIOD_D1,z2)-iClose(NULL,PERIOD_D1,z2)+(1*Point))/Point);
                       }
                     if(iClose(NULL,PERIOD_D1,z2)<iOpen(NULL,PERIOD_D1,z2))
                       {
                        upshadowz2=MathAbs((iHigh(NULL,PERIOD_D1,z2)-iOpen(NULL,PERIOD_D1,z2)+(1*Point))/Point);
                       }

                     Bodyz2=MathAbs(iClose(NULL,PERIOD_D1,z2)-iOpen(NULL,PERIOD_D1,z2))/Point;
                     int nTL22=z2;
                     int MaxNTL22=z2;
                     double MaxBodyTL22=z2;
                     while(nTL22<(nOfCandleW+z2))
                       {
                        double BodyTL22=((iOpen(NULL,PERIOD_D1,nTL22)-iClose(NULL,PERIOD_D1,nTL22))/Point);
                        double dyTL22=MathAbs(BodyTL22);
                        if(dyTL22>MaxBodyTL22)
                          {
                           MaxBodyTL22=dyTL22;
                           MaxNTL22=nTL22;
                          }
                        nTL22++;
                       }

                     int n2TL22=z2;
                     int MaxN2TL22=z2;
                     double MaxBody2TL22=z2;
                     while(n2TL22<(nOfCandleW+z2))
                       {
                        double Body2TL22=((iOpen(NULL,PERIOD_D1,n2TL22)-iClose(NULL,PERIOD_D1,n2TL22))/Point);
                        double dy2TL22=MathAbs(Body2TL22);
                        if(dy2TL22<MaxBodyTL22 && dy2TL22>MaxBody2TL22)
                          {
                           MaxBody2TL22=dy2TL22;
                           MaxN2TL22=n2TL22;
                          }
                        n2TL22++;
                       }

                     double darsadTL22=(Bodyz2/((MaxBodyTL22+MaxBody2TL22)/2))*100;

                     double candlesizeTL22;
                     if(darsadTL22>=61)
                        candlesizeTL22=4;
                     if(darsadTL22<61 && darsadTL22>=41)
                        candlesizeTL22=3;
                     if(darsadTL22<41 && darsadTL22>5)
                        candlesizeTL22=2;
                     if(darsadTL22<=5)
                        candlesizeTL22=1;

                     if(iClose(NULL,PERIOD_D1,z2)<TL && candlesizeTL22>=3 && upshadowz2>=Bodyz2 && iHigh(NULL,PERIOD_D1,z2)>(TL+(MinLimit)))
                       {
                        TL2=iHigh(NULL,PERIOD_D1,z2);
                        if(TL2<minTL2)minTL2=TL2;
                        ObjectCreate("ML TL2 Candid D11-"+z2,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,z2),iOpen(NULL,PERIOD_D1,z2));
                        ObjectSet("ML TL2 Candid D11-"+z2,OBJPROP_STYLE,STYLE_DOT);
                        ObjectSet("ML TL2 Candid D11-"+z2,OBJPROP_COLOR,Blue);
                        ObjectSet("ML TL2 Candid D11-"+z2,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                       }

                     if(iClose(NULL,PERIOD_D1,z2)<TL && candlesizeTL22<3 && upshadowz2>=(2*Bodyz2) && iHigh(NULL,PERIOD_D1,z2)>(TL+(MinLimit)))
                       {
                        TL2=iHigh(NULL,PERIOD_D1,z2);
                        if(TL2<minTL2)minTL2=TL2;
                        ObjectCreate("ML TL2 Candid D12-"+z2,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,z2),iOpen(NULL,PERIOD_D1,z2));
                        ObjectSet("ML TL2 Candid D12-"+z2,OBJPROP_STYLE,STYLE_DOT);
                        ObjectSet("ML TL2 Candid D12-"+z2,OBJPROP_COLOR,Blue);
                        ObjectSet("ML TL2 Candid D12-"+z2,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                       }

                     if(iClose(NULL,PERIOD_D1,z2)<TL && candlesizeTL22>=3 && iHigh(NULL,PERIOD_D1,z2)>(TL+(MinLimit)) && (iClose(NULL,PERIOD_D1,z2)<iOpen(NULL,PERIOD_D1,z2)))
                       {
                        TL2=iHigh(NULL,PERIOD_D1,z2);
                        if(TL2<minTL2)minTL2=TL2;
                        ObjectCreate("ML TL2 Candid D13-"+z2,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,z2),iOpen(NULL,PERIOD_D1,z2));
                        ObjectSet("ML TL2 Candid D13-"+z2,OBJPROP_STYLE,STYLE_DOT);
                        ObjectSet("ML TL2 Candid D13-"+z2,OBJPROP_COLOR,Blue);
                        ObjectSet("ML TL2 Candid D13-"+z2,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                       }

                     if(z2>shoroT && iClose(NULL,PERIOD_D1,z2)>TL && candlesizeTL22>=3 && iHigh(NULL,PERIOD_D1,z2)>(TL+(MinLimit)) && iLow(NULL,PERIOD_D1,(z2-1))<(iClose(NULL,PERIOD_D1,z2)-(0.45*(iClose(NULL,PERIOD_D1,z2)-iOpen(NULL,PERIOD_D1,z2)))))
                       {
                        TL2=MathMax(iHigh(NULL,PERIOD_D1,z2),iHigh(NULL,PERIOD_D1,(z2-1)));
                        if(TL2<minTL2)minTL2=TL2;
                        ObjectCreate("ML TL2 Candid D14-"+z2,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,z2),iOpen(NULL,PERIOD_D1,z2));
                        ObjectSet("ML TL2 Candid D14-"+z2,OBJPROP_STYLE,STYLE_DOT);
                        ObjectSet("ML TL2 Candid D14-"+z2,OBJPROP_COLOR,Blue);
                        ObjectSet("ML TL2 Candid D14-"+z2,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                       }

                    }

                 }
               z2++;
              }

           }
         if(minTL2==TL+((TL-LL)*2))
           {
            int shoroT2=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q));
            ObjectCreate("ML shoroTH4T-"+shoroT2,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,shoroT2-1),iLow(NULL,PERIOD_H4,shoroT2-1));
            ObjectSet("ML shoroTH4T-"+shoroT2,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML shoroTH4T-"+shoroT2,OBJPROP_COLOR,Red);
            ObjectSet("ML shoroTH4T-"+shoroT2,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);

            int z4=shoroT2;
            int nz4=shoroT2;
            int count4=0;
            bool mohiti4;
            double Bodyz4;
            double upshadowz4;

            while(z4<(iBars(NULL,PERIOD_H4)-1) && count4<=MaxTPSLCalc && count4<=iBars(NULL,PERIOD_H4)-2-z4)
              {
                 {
                  if(iHigh(NULL,PERIOD_H4,z4)>LL && iLow(NULL,PERIOD_H4,z4)<TL)
                    {
                     mohiti4=1;
                     count4++;
                     ObjectCreate("ML MohitiTH4T-"+z4,OBJ_ARROW,0,iTime(NULL,PERIOD_H4,z4),iOpen(NULL,PERIOD_H4,z4));
                     ObjectSet("ML MohitiTH4T-"+z4,OBJPROP_COLOR,Blue);
                     ObjectSet("ML MohitiTH4T-"+z4,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                    }
                  else mohiti4=0;
                 }

               if(mohiti4==1)
                 {
                  if((iHigh(NULL,PERIOD_H4,z4)>TL && iOpen(NULL,PERIOD_H4,z4)<TL))
                    {
                     if(iClose(NULL,PERIOD_H4,z4)>iOpen(NULL,PERIOD_H4,z4))
                       {
                        upshadowz4=MathAbs((iHigh(NULL,PERIOD_H4,z4)-iClose(NULL,PERIOD_H4,z4)+(1*Point))/Point);
                       }
                     if(iClose(NULL,PERIOD_H4,z4)<iOpen(NULL,PERIOD_H4,z4))
                       {
                        upshadowz4=MathAbs((iHigh(NULL,PERIOD_H4,z4)-iOpen(NULL,PERIOD_H4,z4)+(1*Point))/Point);
                       }

                     Bodyz4=MathAbs(iClose(NULL,PERIOD_H4,z4)-iOpen(NULL,PERIOD_H4,z4))/Point;
                     int nTL24=z4;
                     int MaxNTL24=z4;
                     double MaxBodyTL24=z4;
                     while(nTL24<(nOfCandleW+z4))
                       {
                        double BodyTL24=((iOpen(NULL,PERIOD_H4,nTL24)-iClose(NULL,PERIOD_H4,nTL24))/Point);
                        double dyTL24=MathAbs(BodyTL24);
                        if(dyTL24>MaxBodyTL24)
                          {
                           MaxBodyTL24=dyTL24;
                           MaxNTL24=nTL24;
                          }
                        nTL24++;
                       }

                     int n2TL24=z4;
                     int MaxN2TL24=z4;
                     double MaxBody2TL24=z4;
                     while(n2TL24<(nOfCandleW+z4))
                       {
                        double Body2TL24=((iOpen(NULL,PERIOD_H4,n2TL24)-iClose(NULL,PERIOD_H4,n2TL24))/Point);
                        double dy2TL24=MathAbs(Body2TL24);
                        if(dy2TL24<MaxBodyTL24 && dy2TL24>MaxBody2TL24)
                          {
                           MaxBody2TL24=dy2TL24;
                           MaxN2TL24=n2TL24;
                          }
                        n2TL24++;
                       }

                     double darsadTL24=(Bodyz4/((MaxBodyTL24+MaxBody2TL24)/2))*100;

                     double candlesizeTL24;
                     if(darsadTL24>=61)
                        candlesizeTL24=4;
                     if(darsadTL24<61 && darsadTL24>=41)
                        candlesizeTL24=3;
                     if(darsadTL24<41 && darsadTL24>5)
                        candlesizeTL24=2;
                     if(darsadTL24<=5)
                        candlesizeTL24=1;

                     if(iClose(NULL,PERIOD_H4,z4)<TL && candlesizeTL24>=3 && upshadowz4>=Bodyz4 && iHigh(NULL,PERIOD_H4,z4)>(TL+(MinLimit)))
                       {
                        TL2=iHigh(NULL,PERIOD_H4,z4);
                        if(TL2<minTL2)minTL2=TL2;
                        ObjectCreate("ML TL2 Candid H41-"+z4,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,z4),iOpen(NULL,PERIOD_H4,z4));
                        ObjectSet("ML TL2 Candid H41-"+z4,OBJPROP_STYLE,STYLE_DOT);
                        ObjectSet("ML TL2 Candid H41-"+z4,OBJPROP_COLOR,Blue);
                        ObjectSet("ML TL2 Candid H41-"+z4,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                       }

                     if(iClose(NULL,PERIOD_H4,z4)<TL && candlesizeTL24<3 && upshadowz4>=(2*Bodyz4) && iHigh(NULL,PERIOD_H4,z4)>(TL+(MinLimit)))
                       {
                        TL2=iHigh(NULL,PERIOD_H4,z4);
                        if(TL2<minTL2)minTL2=TL2;
                        ObjectCreate("ML TL2 Candid H42-"+z4,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,z4),iOpen(NULL,PERIOD_H4,z4));
                        ObjectSet("ML TL2 Candid H42-"+z4,OBJPROP_STYLE,STYLE_DOT);
                        ObjectSet("ML TL2 Candid H42-"+z4,OBJPROP_COLOR,Blue);
                        ObjectSet("ML TL2 Candid H42-"+z4,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                       }

                     if(iClose(NULL,PERIOD_H4,z4)<TL && candlesizeTL24>=3 && iHigh(NULL,PERIOD_H4,z4)>(TL+(MinLimit)) && (iClose(NULL,PERIOD_H4,z4)<iOpen(NULL,PERIOD_H4,z4)))
                       {
                        TL2=iHigh(NULL,PERIOD_H4,z4);
                        if(TL2<minTL2)minTL2=TL2;
                        ObjectCreate("ML TL2 Candid H43-"+z4,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,z4),iOpen(NULL,PERIOD_H4,z4));
                        ObjectSet("ML TL2 Candid H43-"+z4,OBJPROP_STYLE,STYLE_DOT);
                        ObjectSet("ML TL2 Candid H43-"+z4,OBJPROP_COLOR,Blue);
                        ObjectSet("ML TL2 Candid H43-"+z4,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                       }

                     if(z4>shoroT2 && iClose(NULL,PERIOD_H4,z4)>TL && candlesizeTL24>=3 && iHigh(NULL,PERIOD_H4,z4)>(TL+(MinLimit)) && iLow(NULL,PERIOD_H4,(z4-1))<(iClose(NULL,PERIOD_H4,z4)-(0.45*(iClose(NULL,PERIOD_H4,z4)-iOpen(NULL,PERIOD_H4,z4)))))
                       {
                        TL2=MathMax(iHigh(NULL,PERIOD_H4,z4),iHigh(NULL,PERIOD_H4,(z4-1)));
                        if(TL2<minTL2)minTL2=TL2;
                        ObjectCreate("ML TL2 Candid H44-"+z4,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,z4),iOpen(NULL,PERIOD_H4,z4));
                        ObjectSet("ML TL2 Candid H44-"+z4,OBJPROP_STYLE,STYLE_DOT);
                        ObjectSet("ML TL2 Candid H44-"+z4,OBJPROP_COLOR,Blue);
                        ObjectSet("ML TL2 Candid H44-"+z4,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                       }

                    }

                 }
               z4++;
              }

           }

         if(minLL2==LL-((TL-LL)*2))
           {
            int shoroL=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_W1,q));
            ObjectCreate("ML shoroLD1-"+shoroL,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,shoroL-1),iLow(NULL,PERIOD_D1,shoroL-1));
            ObjectSet("ML shoroLD1-"+shoroL,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML shoroLD1-"+shoroL,OBJPROP_COLOR,Red);
            ObjectSet("ML shoroLD1-"+shoroL,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);

            int z3=shoroL;
            int nz3=shoroL;
            int count3=0;
            bool mohiti3;
            double Bodyz3;
            double downshadowz3;

            while(z3<(iBars(NULL,PERIOD_D1)-1) && count3<=MaxTPSLCalc && count3<=iBars(NULL,PERIOD_D1)-2-z3)
              {
                 {
                  if(iHigh(NULL,PERIOD_D1,z3)>LL && iLow(NULL,PERIOD_D1,z3)<TL)
                    {
                     mohiti3=1;
                     count3++;
                     ObjectCreate("ML MohitiTD1L-"+z3,OBJ_ARROW,0,iTime(NULL,PERIOD_D1,z3),iOpen(NULL,PERIOD_D1,z3));
                     ObjectSet("ML MohitiTD1L-"+z3,OBJPROP_COLOR,Blue);
                     ObjectSet("ML MohitiTD1L-"+z3,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }
                  else mohiti3=0;
                 }

               if(mohiti3==1)
                 {

                  if(((iLow(NULL,PERIOD_D1,z3)<LL && iOpen(NULL,PERIOD_D1,z3)>LL)))
                    {

                     if(iClose(NULL,PERIOD_D1,z3)>iOpen(NULL,PERIOD_D1,z3))
                       {
                        downshadowz3=MathAbs((iLow(NULL,PERIOD_D1,z3)-iOpen(NULL,PERIOD_D1,z3)+(1*Point))/Point);
                       }
                     if(iClose(NULL,PERIOD_D1,z3)<iOpen(NULL,PERIOD_D1,z3))
                       {
                        downshadowz3=MathAbs((iLow(NULL,PERIOD_D1,z3)-iClose(NULL,PERIOD_D1,z3)+(1*Point))/Point);
                       }

                     Bodyz3=MathAbs(iClose(NULL,PERIOD_D1,z3)-iOpen(NULL,PERIOD_D1,z3))/Point;
                     int nLL23=z3;
                     int MaxNLL23=z3;
                     double MaxBodyLL23=z3;
                     while(nLL23<(nOfCandleW+z3))
                       {
                        double BodyLL23=((iOpen(NULL,PERIOD_D1,nLL23)-iClose(NULL,PERIOD_D1,nLL23))/Point);
                        double dyLL23=MathAbs(BodyLL23);
                        if(dyLL23>MaxBodyLL23)
                          {
                           MaxBodyLL23=dyLL23;
                           MaxNLL23=nLL23;
                          }
                        nLL23++;
                       }

                     int n2LL23=z3;
                     int MaxN2LL23=z3;
                     double MaxBody2LL23=z3;
                     while(n2LL23<(nOfCandleW+z3))
                       {
                        double Body2LL23=((iOpen(NULL,PERIOD_D1,n2LL23)-iClose(NULL,PERIOD_D1,n2LL23))/Point);
                        double dy2LL23=MathAbs(Body2LL23);
                        if(dy2LL23<MaxBodyLL23 && dy2LL23>MaxBody2LL23)
                          {
                           MaxBody2LL23=dy2LL23;
                           MaxN2LL23=n2LL23;
                          }
                        n2LL23++;
                       }

                     double darsadLL23=(Bodyz3/((MaxBodyLL23+MaxBody2LL23)/2))*100;

                     double candlesizeLL23;
                     if(darsadLL23>=61)
                        candlesizeLL23=4;
                     if(darsadLL23<61 && darsadLL23>=41)
                        candlesizeLL23=3;
                     if(darsadLL23<41 && darsadLL23>5)
                        candlesizeLL23=2;
                     if(darsadLL23<=5)
                        candlesizeLL23=1;

                     if(iClose(NULL,PERIOD_D1,z3)>LL && candlesizeLL23>=3 && downshadowz3>=Bodyz3 && iLow(NULL,PERIOD_D1,z3)<(LL-(MinLimit)))
                       {
                        LL2=iLow(NULL,PERIOD_D1,z3);
                        if(LL2>minLL2)minLL2=LL2;
                        ObjectCreate("ML LL2 Candid LD11-"+z3,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,z3),iOpen(NULL,PERIOD_D1,z3));
                        ObjectSet("ML LL2 Candid LD11-"+z3,OBJPROP_STYLE,STYLE_DOT);
                        ObjectSet("ML LL2 Candid LD11-"+z3,OBJPROP_COLOR,Red);
                        ObjectSet("ML LL2 Candid LD11-"+z3,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                       }

                     if(iClose(NULL,PERIOD_D1,z3)>LL && candlesizeLL23<3 && downshadowz3>=(2*Bodyz3) && iLow(NULL,PERIOD_D1,z3)<(LL-(MinLimit)))
                       {
                        LL2=iLow(NULL,PERIOD_D1,z3);
                        if(LL2>minLL2)minLL2=LL2;
                        ObjectCreate("ML LL2 Candid LD12-"+z3,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,z3),iOpen(NULL,PERIOD_D1,z3));
                        ObjectSet("ML LL2 Candid LD12-"+z3,OBJPROP_STYLE,STYLE_DOT);
                        ObjectSet("ML LL2 Candid LD12-"+z3,OBJPROP_COLOR,Red);
                        ObjectSet("ML LL2 Candid LD12-"+z3,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                       }

                     if(iClose(NULL,PERIOD_D1,z3)>LL && candlesizeLL23>=3 && iLow(NULL,PERIOD_D1,z3)<(LL-(MinLimit)) && (iClose(NULL,PERIOD_D1,z3)>iOpen(NULL,PERIOD_D1,z3)))
                       {
                        LL2=iLow(NULL,PERIOD_D1,z3);
                        if(LL2>minLL2)minLL2=LL2;
                        ObjectCreate("ML LL2 Candid LD13-"+z3,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,z3),iOpen(NULL,PERIOD_D1,z3));
                        ObjectSet("ML LL2 Candid LD13-"+z3,OBJPROP_STYLE,STYLE_DOT);
                        ObjectSet("ML LL2 Candid LD13-"+z3,OBJPROP_COLOR,Red);
                        ObjectSet("ML LL2 Candid LD13-"+z3,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                       }

                     if(z3>shoroL && iClose(NULL,PERIOD_D1,z3)<LL && candlesizeLL23>=3 && iLow(NULL,PERIOD_D1,z3)<(LL-(MinLimit)) && iHigh(NULL,PERIOD_D1,(z3-1))>(iClose(NULL,PERIOD_D1,z3)+(0.45*(iOpen(NULL,PERIOD_D1,z3)-iClose(NULL,PERIOD_D1,z3)))))
                       {
                        LL2=MathMin(iLow(NULL,PERIOD_D1,z3),iLow(NULL,PERIOD_D1,(z3-1)));
                        if(LL2>minLL2)minLL2=LL2;
                        ObjectCreate("ML LL2 Candid LD14-"+z3,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,z3),iOpen(NULL,PERIOD_D1,z3));
                        ObjectSet("ML LL2 Candid LD14-"+z3,OBJPROP_STYLE,STYLE_DOT);
                        ObjectSet("ML LL2 Candid LD14-"+z3,OBJPROP_COLOR,Red);
                        ObjectSet("ML LL2 Candid LD14-"+z3,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                       }

                    }
                 }
               z3++;
              }

           }

         if(minLL2==LL-((TL-LL)*2))
           {
            int shoroL2=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q));
            ObjectCreate("ML shoroLH4L-"+shoroL2,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,shoroL2-1),iLow(NULL,PERIOD_H4,shoroL2-1));
            ObjectSet("ML shoroLH4L-"+shoroL2,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML shoroLH4L-"+shoroL2,OBJPROP_COLOR,Red);
            ObjectSet("ML shoroLH4L-"+shoroL2,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);

            int z5=shoroL2;
            int nz5=shoroL2;
            int count5=0;
            bool mohiti5;
            double Bodyz5;
            double downshadowz5;

            while(z5<(iBars(NULL,PERIOD_H4)-1) && count5<=MaxTPSLCalc && count5<=iBars(NULL,PERIOD_H4)-2-z5)
              {
                 {
                  if(iHigh(NULL,PERIOD_H4,z5)>LL && iLow(NULL,PERIOD_H4,z5)<TL)
                    {
                     mohiti5=1;
                     count5++;
                     ObjectCreate("ML MohitiTH4-"+z5,OBJ_ARROW,0,iTime(NULL,PERIOD_H4,z5),iOpen(NULL,PERIOD_H4,z5));
                     ObjectSet("ML MohitiTH4-"+z5,OBJPROP_COLOR,Blue);
                     ObjectSet("ML MohitiTH4-"+z5,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                    }
                  else mohiti5=0;
                 }

               if(mohiti5==1)
                 {

                  if(((iLow(NULL,PERIOD_H4,z5)<LL && iOpen(NULL,PERIOD_H4,z5)>LL)))
                    {

                     if(iClose(NULL,PERIOD_H4,z5)>iOpen(NULL,PERIOD_H4,z5))
                       {
                        downshadowz5=MathAbs((iLow(NULL,PERIOD_H4,z5)-iOpen(NULL,PERIOD_H4,z5)+(1*Point))/Point);
                       }
                     if(iClose(NULL,PERIOD_H4,z5)<iOpen(NULL,PERIOD_H4,z5))
                       {
                        downshadowz5=MathAbs((iLow(NULL,PERIOD_H4,z5)-iClose(NULL,PERIOD_H4,z5)+(1*Point))/Point);
                       }

                     Bodyz5=MathAbs(iClose(NULL,PERIOD_H4,z5)-iOpen(NULL,PERIOD_H4,z5))/Point;
                     int nLL25=z5;
                     int MaxNLL25=z5;
                     double MaxBodyLL25=z5;
                     while(nLL25<(nOfCandleW+z5))
                       {
                        double BodyLL25=((iOpen(NULL,PERIOD_H4,nLL25)-iClose(NULL,PERIOD_H4,nLL25))/Point);
                        double dyLL25=MathAbs(BodyLL25);
                        if(dyLL25>MaxBodyLL25)
                          {
                           MaxBodyLL25=dyLL25;
                           MaxNLL25=nLL25;
                          }
                        nLL25++;
                       }

                     int n2LL25=z5;
                     int MaxN2LL25=z5;
                     double MaxBody2LL25=z5;
                     while(n2LL25<(nOfCandleW+z5))
                       {
                        double Body2LL25=((iOpen(NULL,PERIOD_H4,n2LL25)-iClose(NULL,PERIOD_H4,n2LL25))/Point);
                        double dy2LL25=MathAbs(Body2LL25);
                        if(dy2LL25<MaxBodyLL25 && dy2LL25>MaxBody2LL25)
                          {
                           MaxBody2LL25=dy2LL25;
                           MaxN2LL25=n2LL25;
                          }
                        n2LL25++;
                       }

                     double darsadLL25=(Bodyz5/((MaxBodyLL25+MaxBody2LL25)/2))*100;

                     double candlesizeLL25;
                     if(darsadLL25>=61)
                        candlesizeLL25=4;
                     if(darsadLL25<61 && darsadLL25>=41)
                        candlesizeLL25=3;
                     if(darsadLL25<41 && darsadLL25>5)
                        candlesizeLL25=2;
                     if(darsadLL25<=5)
                        candlesizeLL25=1;

                     if(iClose(NULL,PERIOD_H4,z5)>LL && candlesizeLL25>=3 && downshadowz5>=Bodyz5 && iLow(NULL,PERIOD_H4,z5)<(LL-(MinLimit)))
                       {
                        LL2=iLow(NULL,PERIOD_H4,z5);
                        if(LL2>minLL2)minLL2=LL2;
                        ObjectCreate("ML LL2 Candid LH41-"+z5,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,z5),iOpen(NULL,PERIOD_H4,z5));
                        ObjectSet("ML LL2 Candid LH41-"+z5,OBJPROP_STYLE,STYLE_DOT);
                        ObjectSet("ML LL2 Candid LH41-"+z5,OBJPROP_COLOR,Red);
                        ObjectSet("ML LL2 Candid LH41-"+z5,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                       }

                     if(iClose(NULL,PERIOD_H4,z5)>LL && candlesizeLL25<3 && downshadowz5>=(2*Bodyz5) && iLow(NULL,PERIOD_H4,z5)<(LL-(MinLimit)))
                       {
                        LL2=iLow(NULL,PERIOD_H4,z5);
                        if(LL2>minLL2)minLL2=LL2;
                        ObjectCreate("ML LL2 Candid LH42-"+z5,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,z5),iOpen(NULL,PERIOD_H4,z5));
                        ObjectSet("ML LL2 Candid LH42-"+z5,OBJPROP_STYLE,STYLE_DOT);
                        ObjectSet("ML LL2 Candid LH42-"+z5,OBJPROP_COLOR,Red);
                        ObjectSet("ML LL2 Candid LH42-"+z5,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                       }

                     if(iClose(NULL,PERIOD_H4,z5)>LL && candlesizeLL25>=3 && iLow(NULL,PERIOD_H4,z5)<(LL-(MinLimit)) && (iClose(NULL,PERIOD_H4,z5)>iOpen(NULL,PERIOD_H4,z5)))
                       {
                        LL2=iLow(NULL,PERIOD_H4,z5);
                        if(LL2>minLL2)minLL2=LL2;
                        ObjectCreate("ML LL2 Candid LH43-"+z5,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,z5),iOpen(NULL,PERIOD_H4,z5));
                        ObjectSet("ML LL2 Candid LH43-"+z5,OBJPROP_STYLE,STYLE_DOT);
                        ObjectSet("ML LL2 Candid LH43-"+z5,OBJPROP_COLOR,Red);
                        ObjectSet("ML LL2 Candid LH43-"+z5,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                       }

                     if(z5>shoroL2 && iClose(NULL,PERIOD_H4,z5)<LL && candlesizeLL25>=3 && iLow(NULL,PERIOD_H4,z5)<(LL-(MinLimit)) && iHigh(NULL,PERIOD_H4,(z5-1))>(iClose(NULL,PERIOD_H4,z5)+(0.45*(iOpen(NULL,PERIOD_H4,z5)-iClose(NULL,PERIOD_H4,z5)))))
                       {
                        LL2=MathMin(iLow(NULL,PERIOD_H4,z5),iLow(NULL,PERIOD_H4,(z5-1)));
                        if(LL2>minLL2)minLL2=LL2;
                        ObjectCreate("ML LL2 Candid LH44-"+z5,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,z5),iOpen(NULL,PERIOD_H4,z5));
                        ObjectSet("ML LL2 Candid LH44-"+z5,OBJPROP_STYLE,STYLE_DOT);
                        ObjectSet("ML LL2 Candid LH44-"+z5,OBJPROP_COLOR,Red);
                        ObjectSet("ML LL2 Candid LH44-"+z5,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                       }

                    }
                 }
               z5++;
              }

           }
         int cntT,cntL;
         if(minTL2==TL+((TL-LL)*2) && cntT==0)
           {
            Alert(Symbol(),"حد دوم بالا یافت نشد");
            if(minLL2!=LL-((TL-LL)*2))
              {
               minTL2=TL+(LL-minLL2);
              }
            cntT=1;
           }
         if(minLL2==LL-((TL-LL)*2) && cntL==0)
           {
            Alert(Symbol(),"حد دوم پایین یافت نشد");
            if(minTL2!=TL+((TL-LL)*2))
              {
               minLL2=LL-(minTL2-TL);
              }
            cntL=1;
           }

         int z_star=q+1;
         int nz_star=q+1;
         double minTL2_star=TL+(600*Point);
         double TL2_star;

         while(z_star<iBars(NULL,PERIOD_W1)-1)
           {
            if(iHigh(NULL,PERIOD_W1,z_star)>(TL+(250*Point)) && iClose(NULL,PERIOD_W1,z_star)<TL && iOpen(NULL,PERIOD_W1,z_star)>LL && iOpen(NULL,PERIOD_W1,z_star)<TL)
              {
               TL2_star=iHigh(NULL,PERIOD_W1,z_star);
               if(TL2_star<minTL2_star)minTL2_star=TL2_star;
              }
            z_star++;
           }

         int y_star=q+1;
         int ny_star=q+1;
         double minLL2_star=LL-(600*Point);
         double LL2_star;
         while(y_star<iBars(NULL,PERIOD_W1)-1)
           {
            if(iLow(NULL,PERIOD_W1,y_star)<(LL-(250*Point)) && iClose(NULL,PERIOD_W1,y_star)>LL && LL<iOpen(NULL,PERIOD_W1,y_star) && iOpen(NULL,PERIOD_W1,y_star)<TL)
              {
               LL2_star=iLow(NULL,PERIOD_W1,y_star);
               if(LL2_star>minLL2_star)minLL2_star=LL2_star;
              }
            y_star++;
           }
         ObjectCreate("ML Start-"+q,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,q-1),0);
         ObjectSet("ML Start-"+q,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSet("ML Start-"+q,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
         ObjectSet("ML Start-"+q,OBJPROP_COLOR,Black);
         ObjectSet("ML Start-"+q,OBJPROP_WIDTH,1);

         ObjectCreate("ML End-"+q,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,q-2),0);
         ObjectSet("ML End-"+q,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
         ObjectSet("ML End-"+q,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSet("ML End-"+q,OBJPROP_COLOR,Black);
         ObjectSet("ML End-"+q,OBJPROP_WIDTH,1);

         ObjectCreate("ML starlineT",OBJ_HLINE,0,Time[0],minTL2_star,0,0);
         ObjectSet("ML starlineT",OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1);
         ObjectSet("ML starlineT",OBJPROP_COLOR,Green);
         ObjectSet("ML starlineT",OBJPROP_WIDTH,0);
         ObjectSet("ML starlineT",OBJPROP_STYLE,STYLE_DOT);

         ObjectCreate("ML starlineL",OBJ_HLINE,0,Time[0],minLL2_star,0,0);
         ObjectSet("ML starlineL",OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1);
         ObjectSet("ML starlineL",OBJPROP_COLOR,Green);
         ObjectSet("ML starlineL",OBJPROP_WIDTH,0);
         ObjectSet("ML starlineL",OBJPROP_STYLE,STYLE_DOT);

         ObjectCreate("ML TL",OBJ_HLINE,0,Time[0],TL,0,0);
         ObjectSet("ML TL",OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1);
         ObjectCreate("ML TL2",OBJ_HLINE,0,Time[0],minTL2,0,0);
         ObjectSet("ML TL2",OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1);
         ObjectCreate("ML LL",OBJ_HLINE,0,Time[0],LL,0,0);
         ObjectSet("ML LL",OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1);
         ObjectCreate("ML LL2",OBJ_HLINE,0,Time[0],minLL2,0,0);
         ObjectSet("ML LL2",OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1);

         ObjectSet("ML TL",OBJPROP_COLOR,Orange);
         ObjectSet("ML TL",OBJPROP_WIDTH,2);
         ObjectSet("ML LL",OBJPROP_COLOR,Orange);
         ObjectSet("ML LL",OBJPROP_WIDTH,2);
         ObjectSet("ML TL2",OBJPROP_COLOR,Purple);
         ObjectSet("ML TL2",OBJPROP_WIDTH,1);
         ObjectSet("ML LL2",OBJPROP_COLOR,Purple);
         ObjectSet("ML LL2",OBJPROP_WIDTH,1);

         Middleinline=LL+((TL-LL)/2);

         ObjectCreate("ML First 0.33",OBJ_HLINE,0,Time[0],Middleinline,0,0);
         ObjectSet("ML First 0.33",OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML First 0.33",OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1);
         ObjectSet("ML First 0.33",OBJPROP_COLOR,Black);

         //----------------------------------------/

         int zX=q;
         int nzX=q;
         int countX=0;
         double BodyzX;
         double upshadowzX;
         double downshadowzX;
         minTL4=minTL2+(TL-LL);

         while(zX<(iBars(NULL,PERIOD_W1)-1) && countX<=MaxTPSLCalc && countX<=iBars(NULL,PERIOD_W1)-2-zX)
           {
            if(iClose(NULL,PERIOD_W1,zX)>iOpen(NULL,PERIOD_W1,zX))
              {
               upshadowzX=MathAbs((iHigh(NULL,PERIOD_W1,zX)-iClose(NULL,PERIOD_W1,zX)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zX)<iOpen(NULL,PERIOD_W1,zX))
              {
               upshadowzX=MathAbs((iHigh(NULL,PERIOD_W1,zX)-iOpen(NULL,PERIOD_W1,zX)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zX)>iOpen(NULL,PERIOD_W1,zX))
              {
               downshadowzX=MathAbs((iLow(NULL,PERIOD_W1,zX)-iOpen(NULL,PERIOD_W1,zX)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zX)<iOpen(NULL,PERIOD_W1,zX))
              {
               downshadowzX=MathAbs((iLow(NULL,PERIOD_W1,zX)-iClose(NULL,PERIOD_W1,zX)+(1*Point))/Point);
              }

            BodyzX=MathAbs(iClose(NULL,PERIOD_W1,zX)-iOpen(NULL,PERIOD_W1,zX))/Point;

            int nTL4=zX;
            int MaxNTL4=zX;
            double MaxBodyTL4=zX;
            while(nTL4<(nOfCandleW+zX))
              {
               double BodyTL4=((iOpen(NULL,PERIOD_W1,nTL4)-iClose(NULL,PERIOD_W1,nTL4))/Point);
               double dyTL4=MathAbs(BodyTL4);
               if(dyTL4>MaxBodyTL4)
                 {
                  MaxBodyTL4=dyTL4;
                  MaxNTL4=nTL4;
                 }
               nTL4++;
              }

            int n2TL4=zX;
            int MaxN2TL4=zX;
            double MaxBody2TL4=zX;
            while(n2TL4<(nOfCandleW+zX))
              {
               double Body2TL4=((iOpen(NULL,PERIOD_W1,n2TL4)-iClose(NULL,PERIOD_W1,n2TL4))/Point);
               double dy2TL4=MathAbs(Body2TL4);
               if(dy2TL4<MaxBodyTL4 && dy2TL4>MaxBody2TL4)
                 {
                  MaxBody2TL4=dy2TL4;
                  MaxN2TL4=n2TL4;
                 }
               n2TL4++;
              }

            double darsadTL4=(BodyzX/((MaxBodyTL4+MaxBody2TL4)/2))*100;

            double candlesizeTL4;
            if(darsadTL4>=59)
               candlesizeTL4=4;
            if(darsadTL4<59 && darsadTL4>=39)
               candlesizeTL4=3;
            if(darsadTL4<39 && darsadTL4>5)
               candlesizeTL4=2;
            if(darsadTL4<=5)
               candlesizeTL4=1;

            if(iLow(NULL,PERIOD_W1,zX)>minTL2+((TL-LL)/variable) && iLow(NULL,PERIOD_W1,zX)<minTL2+(TL-LL) && candlesizeTL4<3 && downshadowzX>=BodyzX)
              {
               TL4=iLow(NULL,PERIOD_W1,zX);
               if(TL4<minTL4)minTL4=TL4;
               ObjectCreate("ML TL4 Candid W1-"+zX,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zX),iHigh(NULL,PERIOD_W1,zX));
               ObjectSet("ML TL4 Candid W1-"+zX,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4 Candid W1-"+zX,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4 Candid W1-"+zX,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }
            if(iLow(NULL,PERIOD_W1,zX)>minTL2+((TL-LL)/variable) && candlesizeTL4>3 && iLow(NULL,PERIOD_W1,zX)<minTL2+(TL-LL) && downshadowzX>=(BodyzX/4))
              {
               TL4=iLow(NULL,PERIOD_W1,zX);
               if(TL4<minTL4)minTL4=TL4;
               ObjectCreate("ML TL4 Candid W2-"+zX,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zX),iHigh(NULL,PERIOD_W1,zX));
               ObjectSet("ML TL4 Candid W2-"+zX,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4 Candid W2-"+zX,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4 Candid W2-"+zX,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }
            if(iLow(NULL,PERIOD_W1,zX)>minTL2+((TL-LL)/variable) && iLow(NULL,PERIOD_W1,zX)<minTL2+(TL-LL) && iClose(NULL,PERIOD_W1,zX)<iOpen(NULL,PERIOD_W1,zX) && iHigh(NULL,PERIOD_W1,(zX-1))>((0.45*BodyzX*Point)+iClose(NULL,PERIOD_W1,zX)) && candlesizeTL4>3)
              {
               TL4=iLow(NULL,PERIOD_W1,zX);
               if(TL4<minTL4)minTL4=TL4;
               ObjectCreate("ML TL4 Candid W3-"+zX,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zX),iHigh(NULL,PERIOD_W1,zX));
               ObjectSet("ML TL4 Candid W3-"+zX,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4 Candid W3-"+zX,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4 Candid W3-"+zX,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }

            zX++;
           }

         if(minTL4==minTL2+(TL-LL) || minTL4>=minTL2+((minTL2-TL)/variable2))
           {
            int shoroLXX=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_W1,q));
            ObjectCreate("ML shoroLD1XX-"+shoroLXX,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,shoroLXX-1),iLow(NULL,PERIOD_D1,shoroLXX-1));
            ObjectSet("ML shoroLD1XX-"+shoroLXX,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML shoroLD1XX-"+shoroLXX,OBJPROP_COLOR,Red);
            ObjectSet("ML shoroLD1XX-"+shoroLXX,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);

            int zXX=q;
            int nzXX=q;
            int countXX=0;
            double BodyzXX;
            double upshadowzXX;
            double downshadowzXX;

            while(zXX<(iBars(NULL,PERIOD_D1)-1) && countXX<=MaxTPSLCalc && countXX<=iBars(NULL,PERIOD_D1)-2-zXX)
              {
               if(iClose(NULL,PERIOD_D1,zXX)>iOpen(NULL,PERIOD_D1,zXX))
                 {
                  upshadowzXX=MathAbs((iHigh(NULL,PERIOD_D1,zXX)-iClose(NULL,PERIOD_D1,zXX)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_D1,zXX)<iOpen(NULL,PERIOD_D1,zXX))
                 {
                  upshadowzXX=MathAbs((iHigh(NULL,PERIOD_D1,zXX)-iOpen(NULL,PERIOD_D1,zXX)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_D1,zXX)>iOpen(NULL,PERIOD_D1,zXX))
                 {
                  downshadowzXX=MathAbs((iLow(NULL,PERIOD_D1,zXX)-iOpen(NULL,PERIOD_D1,zXX)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_D1,zXX)<iOpen(NULL,PERIOD_D1,zXX))
                 {
                  downshadowzXX=MathAbs((iLow(NULL,PERIOD_D1,zXX)-iClose(NULL,PERIOD_D1,zXX)+(1*Point))/Point);
                 }

               BodyzXX=MathAbs(iClose(NULL,PERIOD_D1,zXX)-iOpen(NULL,PERIOD_D1,zXX))/Point;

               int nTL4X=zXX;
               int MaxNTL4X=zXX;
               double MaxBodyTL4X=zXX;
               while(nTL4X<(nOfCandleW+zXX))
                 {
                  double BodyTL4X=((iOpen(NULL,PERIOD_D1,nTL4X)-iClose(NULL,PERIOD_D1,nTL4X))/Point);
                  double dyTL4X=MathAbs(BodyTL4X);
                  if(dyTL4X>MaxBodyTL4X)
                    {
                     MaxBodyTL4X=dyTL4X;
                     MaxNTL4X=nTL4X;
                    }
                  nTL4X++;
                 }

               int n2TL4X=zXX;
               int MaxN2TL4X=zXX;
               double MaxBody2TL4X=zXX;
               while(n2TL4X<(nOfCandleW+zXX))
                 {
                  double Body2TL4X=((iOpen(NULL,PERIOD_D1,n2TL4X)-iClose(NULL,PERIOD_D1,n2TL4X))/Point);
                  double dy2TL4X=MathAbs(Body2TL4X);
                  if(dy2TL4X<MaxBodyTL4X && dy2TL4X>MaxBody2TL4X)
                    {
                     MaxBody2TL4X=dy2TL4X;
                     MaxN2TL4X=n2TL4X;
                    }
                  n2TL4X++;
                 }

               double darsadTL4X=(BodyzXX/((MaxBodyTL4X+MaxBody2TL4X)/2))*100;

               double candlesizeTL4X;
               if(darsadTL4X>=59)
                  candlesizeTL4X=4;
               if(darsadTL4X<59 && darsadTL4X>=39)
                  candlesizeTL4X=3;
               if(darsadTL4X<39 && darsadTL4X>5)
                  candlesizeTL4X=2;
               if(darsadTL4X<=5)
                  candlesizeTL4X=1;

               if(iLow(NULL,PERIOD_D1,zXX)>minTL2+((TL-LL)/variable) && iLow(NULL,PERIOD_D1,zXX)<minTL2+(TL-LL) && candlesizeTL4X<3 && downshadowzXX>=BodyzXX)
                 {
                  TL4=iLow(NULL,PERIOD_D1,zXX);
                  if(TL4<minTL4)minTL4=TL4;
                  ObjectCreate("ML TL4X Candid W1-"+zXX,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zXX),iHigh(NULL,PERIOD_D1,zXX));
                  ObjectSet("ML TL4X Candid W1-"+zXX,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL4X Candid W1-"+zXX,OBJPROP_COLOR,Brown);
                  ObjectSet("ML TL4X Candid W1-"+zXX,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                 }
               if(iLow(NULL,PERIOD_D1,zXX)>minTL2+((TL-LL)/variable) && candlesizeTL4X>3 && iLow(NULL,PERIOD_D1,zXX)<minTL2+(TL-LL) && downshadowzXX>=(BodyzXX/4))
                 {
                  TL4=iLow(NULL,PERIOD_D1,zXX);
                  if(TL4<minTL4)minTL4=TL4;
                  ObjectCreate("ML TL4X Candid W2-"+zXX,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zXX),iHigh(NULL,PERIOD_D1,zXX));
                  ObjectSet("ML TL4X Candid W2-"+zXX,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL4X Candid W2-"+zXX,OBJPROP_COLOR,Brown);
                  ObjectSet("ML TL4X Candid W2-"+zXX,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                 }
               if(iLow(NULL,PERIOD_D1,zXX)>minTL2+((TL-LL)/variable) && iLow(NULL,PERIOD_D1,zXX)<minTL2+(TL-LL) && iClose(NULL,PERIOD_D1,zXX)<iOpen(NULL,PERIOD_D1,zXX) && iHigh(NULL,PERIOD_D1,(zXX-1))>((0.45*BodyzXX*Point)+iClose(NULL,PERIOD_D1,zXX)) && candlesizeTL4X>3)
                 {
                  TL4=iLow(NULL,PERIOD_D1,zXX);
                  if(TL4<minTL4)minTL4=TL4;
                  ObjectCreate("ML TL4X Candid W3-"+zXX,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zXX),iHigh(NULL,PERIOD_D1,zXX));
                  ObjectSet("ML TL4X Candid W3-"+zXX,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL4X Candid W3-"+zXX,OBJPROP_COLOR,Brown);
                  ObjectSet("ML TL4X Candid W3-"+zXX,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                 }

               zXX++;
              }

           }

         if(minTL4==minTL2+(TL-LL) || minTL4>=minTL2+((minTL2-TL)/variable2))
           {
            int shoroLXXX=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q));
            ObjectCreate("ML shoroLD1XXX-"+shoroLXXX,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,shoroLXXX-1),iLow(NULL,PERIOD_H4,shoroLXXX-1));
            ObjectSet("ML shoroLD1XXX-"+shoroLXXX,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML shoroLD1XXX-"+shoroLXXX,OBJPROP_COLOR,Red);
            ObjectSet("ML shoroLD1XXX-"+shoroLXXX,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);

            int zXXX=q;
            int nzXXX=q;
            int countXXX=0;
            double BodyzXXX;
            double upshadowzXXX;
            double downshadowzXXX;

            while(zXXX<(iBars(NULL,PERIOD_H4)-1) && countXXX<=MaxTPSLCalc && countXXX<=iBars(NULL,PERIOD_H4)-2-zXXX)
              {
               if(iClose(NULL,PERIOD_H4,zXXX)>iOpen(NULL,PERIOD_H4,zXXX))
                 {
                  upshadowzXXX=MathAbs((iHigh(NULL,PERIOD_H4,zXXX)-iClose(NULL,PERIOD_H4,zXXX)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_H4,zXXX)<iOpen(NULL,PERIOD_H4,zXXX))
                 {
                  upshadowzXXX=MathAbs((iHigh(NULL,PERIOD_H4,zXXX)-iOpen(NULL,PERIOD_H4,zXXX)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_H4,zXXX)>iOpen(NULL,PERIOD_H4,zXXX))
                 {
                  downshadowzXXX=MathAbs((iLow(NULL,PERIOD_H4,zXXX)-iOpen(NULL,PERIOD_H4,zXXX)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_H4,zXXX)<iOpen(NULL,PERIOD_H4,zXXX))
                 {
                  downshadowzXXX=MathAbs((iLow(NULL,PERIOD_H4,zXXX)-iClose(NULL,PERIOD_H4,zXXX)+(1*Point))/Point);
                 }

               BodyzXXX=MathAbs(iClose(NULL,PERIOD_H4,zXXX)-iOpen(NULL,PERIOD_H4,zXXX))/Point;

               int nTL4XX=zXXX;
               int MaxNTL4XX=zXXX;
               double MaxBodyTL4XX=zXXX;
               while(nTL4XX<(nOfCandleW+zXXX))
                 {
                  double BodyTL4XX=((iOpen(NULL,PERIOD_H4,nTL4XX)-iClose(NULL,PERIOD_H4,nTL4XX))/Point);
                  double dyTL4XX=MathAbs(BodyTL4XX);
                  if(dyTL4XX>MaxBodyTL4XX)
                    {
                     MaxBodyTL4XX=dyTL4XX;
                     MaxNTL4XX=nTL4XX;
                    }
                  nTL4XX++;
                 }

               int n2TL4XX=zXXX;
               int MaxN2TL4XX=zXXX;
               double MaxBody2TL4XX=zXXX;
               while(n2TL4XX<(nOfCandleW+zXXX))
                 {
                  double Body2TL4XX=((iOpen(NULL,PERIOD_H4,n2TL4XX)-iClose(NULL,PERIOD_H4,n2TL4XX))/Point);
                  double dy2TL4XX=MathAbs(Body2TL4XX);
                  if(dy2TL4XX<MaxBodyTL4XX && dy2TL4XX>MaxBody2TL4XX)
                    {
                     MaxBody2TL4XX=dy2TL4XX;
                     MaxN2TL4XX=n2TL4XX;
                    }
                  n2TL4XX++;
                 }

               double darsadTL4XX=(BodyzXXX/((MaxBodyTL4XX+MaxBody2TL4XX)/2))*100;

               double candlesizeTL4XX;
               if(darsadTL4XX>=59)
                  candlesizeTL4XX=4;
               if(darsadTL4XX<59 && darsadTL4XX>=39)
                  candlesizeTL4XX=3;
               if(darsadTL4XX<39 && darsadTL4XX>5)
                  candlesizeTL4XX=2;
               if(darsadTL4XX<=5)
                  candlesizeTL4XX=1;

               if(iLow(NULL,PERIOD_H4,zXXX)>minTL2+((TL-LL)/variable) && iLow(NULL,PERIOD_H4,zXXX)<minTL2+(TL-LL) && candlesizeTL4XX<3 && downshadowzXXX>=BodyzXXX)
                 {
                  TL4=iLow(NULL,PERIOD_H4,zXXX);
                  if(TL4<minTL4)minTL4=TL4;
                  ObjectCreate("ML TL4XX Candid W1-"+zXXX,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zXXX),iHigh(NULL,PERIOD_H4,zXXX));
                  ObjectSet("ML TL4XX Candid W1-"+zXXX,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL4XX Candid W1-"+zXXX,OBJPROP_COLOR,Brown);
                  ObjectSet("ML TL4XX Candid W1-"+zXXX,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                 }
               if(iLow(NULL,PERIOD_H4,zXXX)>minTL2+((TL-LL)/variable) && candlesizeTL4XX>3 && iLow(NULL,PERIOD_H4,zXXX)<minTL2+(TL-LL) && downshadowzXXX>=(BodyzXXX/4))
                 {
                  TL4=iLow(NULL,PERIOD_H4,zXXX);
                  if(TL4<minTL4)minTL4=TL4;
                  ObjectCreate("ML TL4XX Candid W2-"+zXXX,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zXXX),iHigh(NULL,PERIOD_H4,zXXX));
                  ObjectSet("ML TL4XX Candid W2-"+zXXX,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL4XX Candid W2-"+zXXX,OBJPROP_COLOR,Brown);
                  ObjectSet("ML TL4XX Candid W2-"+zXXX,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                 }
               if(iLow(NULL,PERIOD_H4,zXXX)>minTL2+((TL-LL)/variable) && iLow(NULL,PERIOD_H4,zXXX)<minTL2+(TL-LL) && iClose(NULL,PERIOD_H4,zXXX)<iOpen(NULL,PERIOD_H4,zXXX) && iHigh(NULL,PERIOD_H4,(zXXX-1))>((0.45*BodyzXXX*Point)+iClose(NULL,PERIOD_H4,zXXX)) && candlesizeTL4XX>3)
                 {
                  TL4=iLow(NULL,PERIOD_H4,zXXX);
                  if(TL4<minTL4)minTL4=TL4;
                  ObjectCreate("ML TL4XX Candid W3-"+zXXX,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zXXX),iHigh(NULL,PERIOD_H4,zXXX));
                  ObjectSet("ML TL4XX Candid W3-"+zXXX,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL4XX Candid W3-"+zXXX,OBJPROP_COLOR,Brown);
                  ObjectSet("ML TL4XX Candid W3-"+zXXX,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                 }

               zXXX++;
              }

           }
         int zX2=q;
         int nzX2=q;
         int countX2=0;
         double BodyzX2;
         double upshadowzX2;
         double downshadowzX2;
         minTL3=minTL2;

         while(zX2<(iBars(NULL,PERIOD_W1)-1) && countX2<=MaxTPSLCalc && countX2<=iBars(NULL,PERIOD_W1)-2-zX2)
           {
            if(iClose(NULL,PERIOD_W1,zX2)>iOpen(NULL,PERIOD_W1,zX2))
              {
               upshadowzX2=MathAbs((iHigh(NULL,PERIOD_W1,zX2)-iClose(NULL,PERIOD_W1,zX2)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zX2)<iOpen(NULL,PERIOD_W1,zX2))
              {
               upshadowzX2=MathAbs((iHigh(NULL,PERIOD_W1,zX2)-iOpen(NULL,PERIOD_W1,zX2)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zX2)>iOpen(NULL,PERIOD_W1,zX2))
              {
               downshadowzX2=MathAbs((iLow(NULL,PERIOD_W1,zX2)-iOpen(NULL,PERIOD_W1,zX2)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zX2)<iOpen(NULL,PERIOD_W1,zX2))
              {
               downshadowzX2=MathAbs((iLow(NULL,PERIOD_W1,zX2)-iClose(NULL,PERIOD_W1,zX2)+(1*Point))/Point);
              }

            BodyzX2=MathAbs(iClose(NULL,PERIOD_W1,zX2)-iOpen(NULL,PERIOD_W1,zX2))/Point;

            int nTL3=zX2;
            int MaxNTL3=zX2;
            double MaxBodyTL3=zX2;
            while(nTL3<(nOfCandleW+zX2))
              {
               double BodyTL3=((iOpen(NULL,PERIOD_W1,nTL3)-iClose(NULL,PERIOD_W1,nTL3))/Point);
               double dyTL3=MathAbs(BodyTL3);
               if(dyTL3>MaxBodyTL3)
                 {
                  MaxBodyTL3=dyTL3;
                  MaxNTL3=nTL3;
                 }
               nTL3++;
              }

            int n2TL3=zX2;
            int MaxN2TL3=zX2;
            double MaxBody2TL3=zX2;
            while(n2TL3<(nOfCandleW+zX2))
              {
               double Body2TL3=((iOpen(NULL,PERIOD_W1,n2TL3)-iClose(NULL,PERIOD_W1,n2TL3))/Point);
               double dy2TL3=MathAbs(Body2TL3);
               if(dy2TL3<MaxBodyTL3 && dy2TL3>MaxBody2TL3)
                 {
                  MaxBody2TL3=dy2TL3;
                  MaxN2TL3=n2TL3;
                 }
               n2TL3++;
              }

            double darsadTL3=(BodyzX2/((MaxBodyTL3+MaxBody2TL3)/2))*100;

            double candlesizeTL3;
            if(darsadTL3>=59)
               candlesizeTL3=4;
            if(darsadTL3<59 && darsadTL3>=39)
               candlesizeTL3=3;
            if(darsadTL3<39 && darsadTL3>5)
               candlesizeTL3=2;
            if(darsadTL3<=5)
               candlesizeTL3=1;

            minTL3=minTL2;
            if(iLow(NULL,PERIOD_W1,zX2)>TL+((TL-LL)/variable) && iLow(NULL,PERIOD_W1,zX2)<minTL2 && candlesizeTL3<3 && downshadowzX2>=BodyzX2)
              {
               TL3=iLow(NULL,PERIOD_W1,zX2);
               if(TL3<minTL3)minTL3=TL3;
               ObjectCreate("ML TL3 Candid W1-"+zX2,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zX2),iHigh(NULL,PERIOD_W1,zX2));
               ObjectSet("ML TL3 Candid W1-"+zX2,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL3 Candid W1-"+zX2,OBJPROP_COLOR,Yellow);
               ObjectSet("ML TL3 Candid W1-"+zX2,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }
            if(iLow(NULL,PERIOD_W1,zX2)>TL+((TL-LL)/variable) && candlesizeTL3>3 && iLow(NULL,PERIOD_W1,zX2)<minTL2 && downshadowzX2>=(BodyzX2/4))
              {
               TL3=iLow(NULL,PERIOD_W1,zX2);
               if(TL3<minTL3)minTL3=TL3;
               ObjectCreate("ML TL3 Candid W2-"+zX2,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zX2),iHigh(NULL,PERIOD_W1,zX2));
               ObjectSet("ML TL3 Candid W2-"+zX2,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL3 Candid W2-"+zX2,OBJPROP_COLOR,Yellow);
               ObjectSet("ML TL3 Candid W2-"+zX2,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }
            if(iLow(NULL,PERIOD_W1,zX2)>TL+((TL-LL)/variable) && iLow(NULL,PERIOD_W1,zX2)<minTL2 && iClose(NULL,PERIOD_W1,zX2)<iOpen(NULL,PERIOD_W1,zX2) && iHigh(NULL,PERIOD_W1,(zX2-1))>((0.45*BodyzX2*Point)+iClose(NULL,PERIOD_W1,zX2)) && candlesizeTL3>3)
              {
               TL3=iLow(NULL,PERIOD_W1,zX2);
               if(TL3<minTL3)minTL3=TL3;
               ObjectCreate("ML TL4 Candid W3-"+zX2,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zX2),iHigh(NULL,PERIOD_W1,zX2));
               ObjectSet("ML TL4 Candid W3-"+zX2,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4 Candid W3-"+zX2,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4 Candid W3-"+zX2,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }

            zX2++;
           }

         if(minTL3==minTL2 || minTL3>=TL+((minTL2-TL)/variable2))
           {
            int shoroLXXL=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_W1,q));
            ObjectCreate("ML shoroLD1XX-"+shoroLXXL,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,shoroLXXL-1),iLow(NULL,PERIOD_D1,shoroLXXL-1));
            ObjectSet("ML shoroLD1XX-"+shoroLXXL,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML shoroLD1XX-"+shoroLXXL,OBJPROP_COLOR,Red);
            ObjectSet("ML shoroLD1XX-"+shoroLXXL,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);

            int zX2Y=q;
            int nzX2Y=q;
            int countX2Y=0;
            double BodyzX2Y;
            double upshadowzX2Y;
            double downshadowzX2Y;
            minTL3=minTL2;

            while(zX2Y<(iBars(NULL,PERIOD_D1)-1) && countX2Y<=MaxTPSLCalc && countX2Y<=iBars(NULL,PERIOD_D1)-2-zX2Y)
              {
               if(iClose(NULL,PERIOD_D1,zX2Y)>iOpen(NULL,PERIOD_D1,zX2Y))
                 {
                  upshadowzX2Y=MathAbs((iHigh(NULL,PERIOD_D1,zX2Y)-iClose(NULL,PERIOD_D1,zX2Y)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_D1,zX2Y)<iOpen(NULL,PERIOD_D1,zX2Y))
                 {
                  upshadowzX2Y=MathAbs((iHigh(NULL,PERIOD_D1,zX2Y)-iOpen(NULL,PERIOD_D1,zX2Y)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_D1,zX2Y)>iOpen(NULL,PERIOD_D1,zX2Y))
                 {
                  downshadowzX2Y=MathAbs((iLow(NULL,PERIOD_D1,zX2Y)-iOpen(NULL,PERIOD_D1,zX2Y)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_D1,zX2Y)<iOpen(NULL,PERIOD_D1,zX2Y))
                 {
                  downshadowzX2Y=MathAbs((iLow(NULL,PERIOD_D1,zX2Y)-iClose(NULL,PERIOD_D1,zX2Y)+(1*Point))/Point);
                 }

               BodyzX2Y=MathAbs(iClose(NULL,PERIOD_D1,zX2Y)-iOpen(NULL,PERIOD_D1,zX2Y))/Point;

               int nTL3Y=zX2Y;
               int MaxNTL3Y=zX2Y;
               double MaxBodyTL3Y=zX2Y;
               while(nTL3Y<(nOfCandleW+zX2Y))
                 {
                  double BodyTL3Y=((iOpen(NULL,PERIOD_D1,nTL3Y)-iClose(NULL,PERIOD_D1,nTL3Y))/Point);
                  double dyTL3Y=MathAbs(BodyTL3Y);
                  if(dyTL3Y>MaxBodyTL3Y)
                    {
                     MaxBodyTL3Y=dyTL3Y;
                     MaxNTL3Y=nTL3Y;
                    }
                  nTL3Y++;
                 }

               int n2TL3Y=zX2Y;
               int MaxN2TL3Y=zX2Y;
               double MaxBody2TL3Y=zX2Y;
               while(n2TL3Y<(nOfCandleW+zX2Y))
                 {
                  double Body2TL3Y=((iOpen(NULL,PERIOD_D1,n2TL3Y)-iClose(NULL,PERIOD_D1,n2TL3Y))/Point);
                  double dy2TL3Y=MathAbs(Body2TL3Y);
                  if(dy2TL3Y<MaxBodyTL3Y && dy2TL3Y>MaxBody2TL3Y)
                    {
                     MaxBody2TL3Y=dy2TL3Y;
                     MaxN2TL3Y=n2TL3Y;
                    }
                  n2TL3Y++;
                 }

               double darsadTL3Y=(BodyzX2Y/((MaxBodyTL3Y+MaxBody2TL3Y)/2))*100;

               double candlesizeTL3Y;
               if(darsadTL3Y>=59)
                  candlesizeTL3Y=4;
               if(darsadTL3Y<59 && darsadTL3Y>=39)
                  candlesizeTL3Y=3;
               if(darsadTL3Y<39 && darsadTL3Y>5)
                  candlesizeTL3Y=2;
               if(darsadTL3Y<=5)
                  candlesizeTL3Y=1;

               if(iLow(NULL,PERIOD_D1,zX2Y)>TL+((TL-LL)/variable) && iLow(NULL,PERIOD_D1,zX2Y)<minTL2 && candlesizeTL3Y<3 && downshadowzX2Y>=BodyzX2Y)
                 {
                  TL3=iLow(NULL,PERIOD_D1,zX2Y);
                  if(TL3<minTL3)minTL3=TL3;
                  ObjectCreate("ML TL3Y Candid W1-"+zX2Y,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zX2Y),iHigh(NULL,PERIOD_D1,zX2Y));
                  ObjectSet("ML TL3Y Candid W1-"+zX2Y,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL3Y Candid W1-"+zX2Y,OBJPROP_COLOR,Yellow);
                  ObjectSet("ML TL3Y Candid W1-"+zX2Y,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                 }
               if(iLow(NULL,PERIOD_D1,zX2Y)>TL+((TL-LL)/variable) && candlesizeTL3Y>3 && iLow(NULL,PERIOD_D1,zX2Y)<minTL2 && downshadowzX2Y>=(BodyzX2Y/4))
                 {
                  TL3=iLow(NULL,PERIOD_D1,zX2Y);
                  if(TL3<minTL3)minTL3=TL3;
                  ObjectCreate("ML TL3Y Candid W2-"+zX2Y,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zX2Y),iHigh(NULL,PERIOD_D1,zX2Y));
                  ObjectSet("ML TL3Y Candid W2-"+zX2Y,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL3Y Candid W2-"+zX2Y,OBJPROP_COLOR,Yellow);
                  ObjectSet("ML TL3Y Candid W2-"+zX2Y,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                 }
               if(iLow(NULL,PERIOD_D1,zX2Y)>TL+((TL-LL)/variable) && iLow(NULL,PERIOD_D1,zX2Y)<minTL2 && iClose(NULL,PERIOD_D1,zX2Y)<iOpen(NULL,PERIOD_D1,zX2Y) && iHigh(NULL,PERIOD_D1,(zX2Y-1))>iClose(NULL,PERIOD_D1,zX2Y)+(0.45*BodyzX2Y*Point) && candlesizeTL3Y>3)
                 {
                  TL4=iLow(NULL,PERIOD_D1,zX2Y);
                  if(TL3<minTL3)minTL3=TL3;
                  ObjectCreate("ML TL4Y Candid W3-"+zX2Y,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zX2Y),iHigh(NULL,PERIOD_D1,zX2Y));
                  ObjectSet("ML TL4Y Candid W3-"+zX2Y,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL4Y Candid W3-"+zX2Y,OBJPROP_COLOR,Brown);
                  ObjectSet("ML TL4Y Candid W3-"+zX2Y,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                 }

               zX2Y++;
              }

           }

         if(minTL3==minTL2 || minTL3>=TL+((minTL2-TL)/variable2))
           {
            int shoroLXXLL=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q));
            ObjectCreate("ML shoroLD1XXL-"+shoroLXXLL,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,shoroLXXLL-1),iLow(NULL,PERIOD_H4,shoroLXXLL-1));
            ObjectSet("ML shoroLD1XXL-"+shoroLXXLL,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML shoroLD1XXL-"+shoroLXXLL,OBJPROP_COLOR,Red);
            ObjectSet("ML shoroLD1XXL-"+shoroLXXLL,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);

            int zX2YY=q;
            int nzX2YY=q;
            int countX2YY=0;
            double BodyzX2YY;
            double upshadowzX2YY;
            double downshadowzX2YY;
            minTL3=minTL2;

            while(zX2YY<(iBars(NULL,PERIOD_H4)-1) && countX2YY<=MaxTPSLCalc && countX2YY<=iBars(NULL,PERIOD_H4)-2-zX2YY)
              {
               if(iClose(NULL,PERIOD_H4,zX2YY)>iOpen(NULL,PERIOD_H4,zX2YY))
                 {
                  upshadowzX2YY=MathAbs((iHigh(NULL,PERIOD_H4,zX2YY)-iClose(NULL,PERIOD_H4,zX2YY)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_H4,zX2YY)<iOpen(NULL,PERIOD_H4,zX2YY))
                 {
                  upshadowzX2YY=MathAbs((iHigh(NULL,PERIOD_H4,zX2YY)-iOpen(NULL,PERIOD_H4,zX2YY)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_H4,zX2YY)>iOpen(NULL,PERIOD_H4,zX2YY))
                 {
                  downshadowzX2YY=MathAbs((iLow(NULL,PERIOD_H4,zX2YY)-iOpen(NULL,PERIOD_H4,zX2YY)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_H4,zX2YY)<iOpen(NULL,PERIOD_H4,zX2YY))
                 {
                  downshadowzX2YY=MathAbs((iLow(NULL,PERIOD_H4,zX2YY)-iClose(NULL,PERIOD_H4,zX2YY)+(1*Point))/Point);
                 }

               BodyzX2YY=MathAbs(iClose(NULL,PERIOD_H4,zX2YY)-iOpen(NULL,PERIOD_H4,zX2YY))/Point;

               int nTL3YY=zX2YY;
               int MaxNTL3YY=zX2YY;
               double MaxBodyTL3YY=zX2YY;
               while(nTL3YY<(nOfCandleW+zX2YY))
                 {
                  double BodyTL3YY=((iOpen(NULL,PERIOD_H4,nTL3YY)-iClose(NULL,PERIOD_H4,nTL3YY))/Point);
                  double dyTL3YY=MathAbs(BodyTL3YY);
                  if(dyTL3YY>MaxBodyTL3YY)
                    {
                     MaxBodyTL3YY=dyTL3YY;
                     MaxNTL3YY=nTL3YY;
                    }
                  nTL3YY++;
                 }

               int n2TL3YY=zX2YY;
               int MaxN2TL3YY=zX2YY;
               double MaxBody2TL3YY=zX2YY;
               while(n2TL3YY<(nOfCandleW+zX2YY))
                 {
                  double Body2TL3YY=((iOpen(NULL,PERIOD_H4,n2TL3YY)-iClose(NULL,PERIOD_H4,n2TL3YY))/Point);
                  double dy2TL3YY=MathAbs(Body2TL3YY);
                  if(dy2TL3YY<MaxBodyTL3YY && dy2TL3YY>MaxBody2TL3YY)
                    {
                     MaxBody2TL3YY=dy2TL3YY;
                     MaxN2TL3YY=n2TL3YY;
                    }
                  n2TL3YY++;
                 }

               double darsadTL3YY=(BodyzX2YY/((MaxBodyTL3YY+MaxBody2TL3YY)/2))*100;

               double candlesizeTL3YY;
               if(darsadTL3YY>=59)
                  candlesizeTL3YY=4;
               if(darsadTL3YY<59 && darsadTL3YY>=39)
                  candlesizeTL3YY=3;
               if(darsadTL3YY<39 && darsadTL3YY>5)
                  candlesizeTL3YY=2;
               if(darsadTL3YY<=5)
                  candlesizeTL3YY=1;

               if(iLow(NULL,PERIOD_H4,zX2YY)>TL+((TL-LL)/variable) && iLow(NULL,PERIOD_H4,zX2YY)<minTL2 && candlesizeTL3YY<3 && downshadowzX2YY>=BodyzX2YY)
                 {
                  TL3=iLow(NULL,PERIOD_H4,zX2YY);
                  if(TL3<minTL3)minTL3=TL3;
                  ObjectCreate("ML TL3YY Candid W1-"+zX2YY,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zX2YY),iHigh(NULL,PERIOD_H4,zX2YY));
                  ObjectSet("ML TL3YY Candid W1-"+zX2YY,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL3YY Candid W1-"+zX2YY,OBJPROP_COLOR,Yellow);
                  ObjectSet("ML TL3YY Candid W1-"+zX2YY,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                 }
               if(iLow(NULL,PERIOD_H4,zX2YY)>TL+((TL-LL)/variable) && candlesizeTL3YY>3 && iLow(NULL,PERIOD_H4,zX2YY)<minTL2 && downshadowzX2YY>=(BodyzX2YY/4))
                 {
                  TL3=iLow(NULL,PERIOD_H4,zX2YY);
                  if(TL3<minTL3)minTL3=TL3;
                  ObjectCreate("ML TL3YY Candid W2-"+zX2YY,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zX2YY),iHigh(NULL,PERIOD_H4,zX2YY));
                  ObjectSet("ML TL3YY Candid W2-"+zX2YY,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL3YY Candid W2-"+zX2YY,OBJPROP_COLOR,Yellow);
                  ObjectSet("ML TL3YY Candid W2-"+zX2YY,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                 }
               if(iLow(NULL,PERIOD_H4,zX2YY)>TL+((TL-LL)/variable) && iLow(NULL,PERIOD_H4,zX2YY)<minTL2 && iClose(NULL,PERIOD_H4,zX2YY)<iOpen(NULL,PERIOD_H4,zX2YY) && iHigh(NULL,PERIOD_H4,(zX2YY-1))>iClose(NULL,PERIOD_H4,zX2YY)+(0.45*BodyzX2YY*Point) && candlesizeTL3YY>3)
                 {
                  TL4=iLow(NULL,PERIOD_H4,zX2YY);
                  if(TL3<minTL3)minTL3=TL3;
                  ObjectCreate("ML TL4YY Candid W3-"+zX2YY,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zX2YY),iHigh(NULL,PERIOD_H4,zX2YY));
                  ObjectSet("ML TL4YY Candid W3-"+zX2YY,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL4YY Candid W3-"+zX2YY,OBJPROP_COLOR,Brown);
                  ObjectSet("ML TL4YY Candid W3-"+zX2YY,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                 }

               zX2YY++;
              }

           }

         int zQ=q;
         int nzQ=q;
         int countQ=0;
         double BodyzQ;
         double upshadowzQ;
         double downshadowzQ;
         minLL3=minLL2;

         while(zQ<(iBars(NULL,PERIOD_W1)-1) && countQ<=MaxTPSLCalc && countQ<=iBars(NULL,PERIOD_W1)-2-zQ)
           {
            if(iClose(NULL,PERIOD_W1,zQ)>iOpen(NULL,PERIOD_W1,zQ))
              {
               upshadowzQ=MathAbs((iHigh(NULL,PERIOD_W1,zQ)-iClose(NULL,PERIOD_W1,zQ)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zQ)<iOpen(NULL,PERIOD_W1,zQ))
              {
               upshadowzQ=MathAbs((iHigh(NULL,PERIOD_W1,zQ)-iOpen(NULL,PERIOD_W1,zQ)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zQ)>iOpen(NULL,PERIOD_W1,zQ))
              {
               downshadowzQ=MathAbs((iLow(NULL,PERIOD_W1,zQ)-iOpen(NULL,PERIOD_W1,zQ)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zQ)<iOpen(NULL,PERIOD_W1,zQ))
              {
               downshadowzQ=MathAbs((iLow(NULL,PERIOD_W1,zQ)-iClose(NULL,PERIOD_W1,zQ)+(1*Point))/Point);
              }

            BodyzQ=MathAbs(iClose(NULL,PERIOD_W1,zQ)-iOpen(NULL,PERIOD_W1,zQ))/Point;

            int nLL3=zQ;
            int MaxNLL3=zQ;
            double MaxBodyLL3=zQ;
            while(nLL3<(nOfCandleW+zQ))
              {
               double BodyLL3=((iOpen(NULL,PERIOD_W1,nLL3)-iClose(NULL,PERIOD_W1,nLL3))/Point);
               double dyLL3=MathAbs(BodyLL3);
               if(dyLL3>MaxBodyLL3)
                 {
                  MaxBodyLL3=dyLL3;
                  MaxNLL3=nLL3;
                 }
               nLL3++;
              }

            int n2LL3=zQ;
            int MaxN2LL3=zQ;
            double MaxBody2LL3=zQ;
            while(n2LL3<(nOfCandleW+zQ))
              {
               double Body2LL3=((iOpen(NULL,PERIOD_W1,n2LL3)-iClose(NULL,PERIOD_W1,n2LL3))/Point);
               double dy2LL3=MathAbs(Body2LL3);
               if(dy2LL3<MaxBodyLL3 && dy2LL3>MaxBody2LL3)
                 {
                  MaxBody2LL3=dy2LL3;
                  MaxN2LL3=n2LL3;
                 }
               n2LL3++;
              }

            double darsadLL3=(BodyzQ/((MaxBodyLL3+MaxBody2LL3)/2))*100;

            double candlesizeLL3;
            if(darsadLL3>=59)
               candlesizeLL3=4;
            if(darsadLL3<59 && darsadLL3>=39)
               candlesizeLL3=3;
            if(darsadLL3<39 && darsadLL3>5)
               candlesizeLL3=2;
            if(darsadLL3<=5)
               candlesizeLL3=1;

            if(iHigh(NULL,PERIOD_W1,zQ)<LL-((TL-LL)/variable) && iHigh(NULL,PERIOD_W1,zQ)>minLL2 && candlesizeLL3<3 && upshadowzQ>=BodyzQ)
              {
               LL3=iHigh(NULL,PERIOD_W1,zQ);
               if(LL3>minLL3)minLL3=LL3;
               ObjectCreate("ML LL3 Candid W1-"+zQ,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zQ),iLow(NULL,PERIOD_W1,zQ));
               ObjectSet("ML LL3 Candid W1-"+zQ,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL3 Candid W1-"+zQ,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL3 Candid W1-"+zQ,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }
            if(iHigh(NULL,PERIOD_W1,zQ)<LL-((TL-LL)/variable) && candlesizeLL3>3 && iHigh(NULL,PERIOD_W1,zQ)>minLL2 && upshadowzQ>=(BodyzQ/4))
              {
               LL3=iHigh(NULL,PERIOD_W1,zQ);
               if(LL3>minLL3)minLL3=LL3;
               ObjectCreate("ML LL3 Candid W2-"+zQ,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zQ),iHigh(NULL,PERIOD_W1,zQ));
               ObjectSet("ML LL3 Candid W2-"+zQ,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL3 Candid W2-"+zQ,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL3 Candid W2-"+zQ,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }
            if(iHigh(NULL,PERIOD_W1,zQ)<LL-((TL-LL)/variable) && iHigh(NULL,PERIOD_W1,zQ)>minLL2 && iClose(NULL,PERIOD_W1,zQ)>iOpen(NULL,PERIOD_W1,zQ) && iLow(NULL,PERIOD_W1,(zQ-1))<(iClose(NULL,PERIOD_W1,zQ)-(0.45*BodyzQ*Point)) && candlesizeLL3>3)
              {
               LL3=iHigh(NULL,PERIOD_W1,zQ);
               if(LL3>minLL3)minLL3=LL3;
               ObjectCreate("ML LL3 Candid W3-"+zQ,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zQ),iHigh(NULL,PERIOD_W1,zQ));
               ObjectSet("ML LL3 Candid W3-"+zQ,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL3 Candid W3-"+zQ,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL3 Candid W3-"+zQ,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }

            zQ++;
           }

         if(minLL3==minLL2 || minLL3<=LL-((LL-minLL2)/variable2))
           {
            int shoroLQQ=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_W1,q));
            ObjectCreate("ML shoroLD1QQ-"+shoroLQQ,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,shoroLQQ-1),iLow(NULL,PERIOD_D1,shoroLQQ-1));
            ObjectSet("ML shoroLD1QQ-"+shoroLQQ,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML shoroLD1QQ-"+shoroLQQ,OBJPROP_COLOR,Red);
            ObjectSet("ML shoroLD1QQ-"+shoroLQQ,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);

            int zQQ=q;
            int nzQQ=q;
            int countQQ=0;
            double BodyzQQ;
            double upshadowzQQ;
            double downshadowzQQ;

            while(zQQ<(iBars(NULL,PERIOD_D1)-1) && countQQ<=MaxTPSLCalc && countQQ<=iBars(NULL,PERIOD_D1)-2-zQQ)
              {
               if(iClose(NULL,PERIOD_D1,zQQ)>iOpen(NULL,PERIOD_D1,zQQ))
                 {
                  upshadowzQQ=MathAbs((iHigh(NULL,PERIOD_D1,zQQ)-iClose(NULL,PERIOD_D1,zQQ)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_D1,zQQ)<iOpen(NULL,PERIOD_D1,zQQ))
                 {
                  upshadowzQQ=MathAbs((iHigh(NULL,PERIOD_D1,zQQ)-iOpen(NULL,PERIOD_D1,zQQ)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_D1,zQQ)>iOpen(NULL,PERIOD_D1,zQQ))
                 {
                  downshadowzQQ=MathAbs((iLow(NULL,PERIOD_D1,zQQ)-iOpen(NULL,PERIOD_D1,zQQ)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_D1,zQQ)<iOpen(NULL,PERIOD_D1,zQQ))
                 {
                  downshadowzQQ=MathAbs((iLow(NULL,PERIOD_D1,zQQ)-iClose(NULL,PERIOD_D1,zQQ)+(1*Point))/Point);
                 }

               BodyzQQ=MathAbs(iClose(NULL,PERIOD_D1,zQQ)-iOpen(NULL,PERIOD_D1,zQQ))/Point;

               int nLL3Q=zQQ;
               int MaxNLL3Q=zQQ;
               double MaxBodyLL3Q=zQQ;
               while(nLL3Q<(nOfCandleW+zQQ))
                 {
                  double BodyLL3Q=((iOpen(NULL,PERIOD_D1,nLL3Q)-iClose(NULL,PERIOD_D1,nLL3Q))/Point);
                  double dyLL3Q=MathAbs(BodyLL3Q);
                  if(dyLL3Q>MaxBodyLL3Q)
                    {
                     MaxBodyLL3Q=dyLL3Q;
                     MaxNLL3Q=nLL3Q;
                    }
                  nLL3Q++;
                 }

               int n2LL3Q=zQQ;
               int MaxN2LL3Q=zQQ;
               double MaxBody2LL3Q=zQQ;
               while(n2LL3Q<(nOfCandleW+zQQ))
                 {
                  double Body2LL3Q=((iOpen(NULL,PERIOD_D1,n2LL3Q)-iClose(NULL,PERIOD_D1,n2LL3Q))/Point);
                  double dy2LL3Q=MathAbs(Body2LL3Q);
                  if(dy2LL3Q<MaxBodyLL3Q && dy2LL3Q>MaxBody2LL3Q)
                    {
                     MaxBody2LL3Q=dy2LL3Q;
                     MaxN2LL3Q=n2LL3Q;
                    }
                  n2LL3Q++;
                 }

               double darsadLL3Q=(BodyzQQ/((MaxBodyLL3Q+MaxBody2LL3Q)/2))*100;

               double candlesizeLL3Q;
               if(darsadLL3Q>=59)
                  candlesizeLL3Q=4;
               if(darsadLL3Q<59 && darsadLL3Q>=39)
                  candlesizeLL3Q=3;
               if(darsadLL3Q<39 && darsadLL3Q>5)
                  candlesizeLL3Q=2;
               if(darsadLL3Q<=5)
                  candlesizeLL3Q=1;

               if(iHigh(NULL,PERIOD_D1,zQQ)<LL-((TL-LL)/variable) && iHigh(NULL,PERIOD_D1,zQQ)>minLL2 && candlesizeLL3Q<3 && upshadowzQQ>=BodyzQQ)
                 {
                  LL3=iHigh(NULL,PERIOD_D1,zQQ);
                  if(LL3>minLL3)minLL3=LL3;
                  ObjectCreate("ML LL3Q Candid W1-"+zQQ,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zQQ),iHigh(NULL,PERIOD_D1,zQQ));
                  ObjectSet("ML LL3Q Candid W1-"+zQQ,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL3Q Candid W1-"+zQQ,OBJPROP_COLOR,Brown);
                  ObjectSet("ML LL3Q Candid W1-"+zQQ,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                 }
               if(iHigh(NULL,PERIOD_D1,zQQ)<LL-((TL-LL)/variable) && candlesizeLL3Q>3 && iHigh(NULL,PERIOD_D1,zQQ)>minLL2 && upshadowzQQ>=(BodyzQQ/4))
                 {
                  LL3=iHigh(NULL,PERIOD_D1,zQQ);
                  if(LL3>minLL3)minLL3=LL3;
                  ObjectCreate("ML LL3Q Candid W2-"+zQQ,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zQQ),iHigh(NULL,PERIOD_D1,zQQ));
                  ObjectSet("ML LL3Q Candid W2-"+zQQ,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL3Q Candid W2-"+zQQ,OBJPROP_COLOR,Brown);
                  ObjectSet("ML LL3Q Candid W2-"+zQQ,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                 }
               if(iHigh(NULL,PERIOD_D1,zQQ)<LL-((TL-LL)/variable) && iHigh(NULL,PERIOD_D1,zQQ)>minLL2 && iClose(NULL,PERIOD_D1,zQQ)>iOpen(NULL,PERIOD_D1,zQQ) && iLow(NULL,PERIOD_D1,(zQQ-1))<(iClose(NULL,PERIOD_D1,zQQ)-(0.45*BodyzQQ*Point)) && candlesizeLL3Q>3)
                 {
                  LL3=iHigh(NULL,PERIOD_D1,zQQ);
                  if(LL3>minLL3)minLL3=LL3;
                  ObjectCreate("ML LL3Q Candid W3-"+zQQ,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zQQ),iHigh(NULL,PERIOD_D1,zQQ));
                  ObjectSet("ML LL3Q Candid W3-"+zQQ,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL3Q Candid W3-"+zQQ,OBJPROP_COLOR,Brown);
                  ObjectSet("ML LL3Q Candid W3-"+zQQ,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                 }

               zQQ++;
              }

           }

         if(minLL3==minLL2 || minLL3<=LL-((LL-minLL2)/variable2))
           {
            int shoroLQQQ=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q));
            ObjectCreate("ML shoroLD1QQQ-"+shoroLQQQ,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,shoroLQQQ-1),iLow(NULL,PERIOD_H4,shoroLQQQ-1));
            ObjectSet("ML shoroLD1QQQ-"+shoroLQQQ,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML shoroLD1QQQ-"+shoroLQQQ,OBJPROP_COLOR,Red);
            ObjectSet("ML shoroLD1QQQ-"+shoroLQQQ,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);

            int zQQQ=q;
            int nzQQQ=q;
            int countQQQ=0;
            double BodyzQQQ;
            double upshadowzQQQ;
            double downshadowzQQQ;

            while(zQQQ<(iBars(NULL,PERIOD_H4)-1) && countQQQ<=MaxTPSLCalc && countQQQ<=iBars(NULL,PERIOD_H4)-2-zQQQ)
              {
               if(iClose(NULL,PERIOD_H4,zQQQ)>iOpen(NULL,PERIOD_H4,zQQQ))
                 {
                  upshadowzQQQ=MathAbs((iHigh(NULL,PERIOD_H4,zQQQ)-iClose(NULL,PERIOD_H4,zQQQ)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_H4,zQQQ)<iOpen(NULL,PERIOD_H4,zQQQ))
                 {
                  upshadowzQQQ=MathAbs((iHigh(NULL,PERIOD_H4,zQQQ)-iOpen(NULL,PERIOD_H4,zQQQ)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_H4,zQQQ)>iOpen(NULL,PERIOD_H4,zQQQ))
                 {
                  downshadowzQQQ=MathAbs((iLow(NULL,PERIOD_H4,zQQQ)-iOpen(NULL,PERIOD_H4,zQQQ)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_H4,zQQQ)<iOpen(NULL,PERIOD_H4,zQQQ))
                 {
                  downshadowzQQQ=MathAbs((iLow(NULL,PERIOD_H4,zQQQ)-iClose(NULL,PERIOD_H4,zQQQ)+(1*Point))/Point);
                 }

               BodyzQQQ=MathAbs(iClose(NULL,PERIOD_H4,zQQQ)-iOpen(NULL,PERIOD_H4,zQQQ))/Point;

               int nLL3QQ=zQQQ;
               int MaxNLL3QQ=zQQQ;
               double MaxBodyLL3QQ=zQQQ;
               while(nLL3QQ<(nOfCandleW+zQQQ))
                 {
                  double BodyLL3QQ=((iOpen(NULL,PERIOD_H4,nLL3QQ)-iClose(NULL,PERIOD_H4,nLL3QQ))/Point);
                  double dyLL3QQ=MathAbs(BodyLL3QQ);
                  if(dyLL3Q>MaxBodyLL3QQ)
                    {
                     MaxBodyLL3QQ=dyLL3QQ;
                     MaxNLL3QQ=nLL3QQ;
                    }
                  nLL3QQ++;
                 }

               int n2LL3QQ=zQQQ;
               int MaxN2LL3QQ=zQQQ;
               double MaxBody2LL3QQ=zQQQ;
               while(n2LL3QQ<(nOfCandleW+zQQQ))
                 {
                  double Body2LL3QQ=((iOpen(NULL,PERIOD_H4,n2LL3QQ)-iClose(NULL,PERIOD_H4,n2LL3QQ))/Point);
                  double dy2LL3QQ=MathAbs(Body2LL3QQ);
                  if(dy2LL3QQ<MaxBodyLL3QQ && dy2LL3QQ>MaxBody2LL3QQ)
                    {
                     MaxBody2LL3QQ=dy2LL3QQ;
                     MaxN2LL3QQ=n2LL3QQ;
                    }
                  n2LL3QQ++;
                 }

               double darsadLL3QQ=(BodyzQQQ/((MaxBodyLL3QQ+MaxBody2LL3QQ)/2))*100;

               double candlesizeLL3QQ;
               if(darsadLL3QQ>=59)
                  candlesizeLL3QQ=4;
               if(darsadLL3QQ<59 && darsadLL3QQ>=39)
                  candlesizeLL3QQ=3;
               if(darsadLL3QQ<39 && darsadLL3QQ>5)
                  candlesizeLL3QQ=2;
               if(darsadLL3QQ<=5)
                  candlesizeLL3QQ=1;

               if(iHigh(NULL,PERIOD_H4,zQQQ)<LL-((TL-LL)/variable) && iHigh(NULL,PERIOD_H4,zQQQ)>LL2 && candlesizeLL3QQ<3 && upshadowzQQQ>=BodyzQQQ)
                 {
                  LL3=iHigh(NULL,PERIOD_H4,zQQQ);
                  if(LL3>minLL3)minLL3=LL3;
                  ObjectCreate("ML LL3QQ Candid W1-"+zQQQ,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zQQQ),iHigh(NULL,PERIOD_H4,zQQQ));
                  ObjectSet("ML LL3QQ Candid W1-"+zQQQ,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL3QQ Candid W1-"+zQQQ,OBJPROP_COLOR,Brown);
                  ObjectSet("ML LL3QQ Candid W1-"+zQQQ,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                 }
               if(iHigh(NULL,PERIOD_H4,zQQQ)<LL-((TL-LL)/variable) && candlesizeLL3QQ>3 && iHigh(NULL,PERIOD_H4,zQQQ)>LL2 && upshadowzQQQ>=(BodyzQQQ/4))
                 {
                  LL3=iHigh(NULL,PERIOD_H4,zQQQ);
                  if(LL3>minLL3)minLL3=LL3;
                  ObjectCreate("ML LL3QQ Candid W2-"+zQQQ,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zQQQ),iHigh(NULL,PERIOD_H4,zQQQ));
                  ObjectSet("ML LL3QQ Candid W2-"+zQQQ,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL3QQ Candid W2-"+zQQQ,OBJPROP_COLOR,Brown);
                  ObjectSet("ML LL3QQ Candid W2-"+zQQQ,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                 }
               if(iHigh(NULL,PERIOD_H4,zQQQ)<LL-((TL-LL)/variable) && iHigh(NULL,PERIOD_H4,zQQQ)>LL2 && iClose(NULL,PERIOD_H4,zQQQ)>iOpen(NULL,PERIOD_H4,zQQQ) && iLow(NULL,PERIOD_H4,(zQQQ-1))<(iClose(NULL,PERIOD_H4,zQQQ)-(0.45*BodyzQQQ*Point)) && candlesizeLL3QQ>3)
                 {
                  LL3=iHigh(NULL,PERIOD_H4,zQQQ);
                  if(LL3>minLL3)minLL3=LL3;
                  ObjectCreate("ML LL3QQ Candid W3-"+zQQQ,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zQQQ),iHigh(NULL,PERIOD_H4,zQQQ));
                  ObjectSet("ML LL3QQ Candid W3-"+zQQQ,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL3QQ Candid W3-"+zQQQ,OBJPROP_COLOR,Brown);
                  ObjectSet("ML LL3QQ Candid W3-"+zQQQ,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                 }

               zQQQ++;
              }

           }

         int zV=q;
         int nzV=q;
         int countV=0;
         double BodyzV;
         double upshadowzV;
         double downshadowzV;
         minLL4=minLL2-(TL-LL);

         while(zV<(iBars(NULL,PERIOD_W1)-1) && countV<=MaxTPSLCalc && countV<=iBars(NULL,PERIOD_W1)-2-zV)
           {
            if(iClose(NULL,PERIOD_W1,zV)>iOpen(NULL,PERIOD_W1,zV))
              {
               upshadowzV=MathAbs((iHigh(NULL,PERIOD_W1,zV)-iClose(NULL,PERIOD_W1,zV)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zV)<iOpen(NULL,PERIOD_W1,zV))
              {
               upshadowzV=MathAbs((iHigh(NULL,PERIOD_W1,zV)-iOpen(NULL,PERIOD_W1,zV)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zV)>iOpen(NULL,PERIOD_W1,zV))
              {
               downshadowzV=MathAbs((iLow(NULL,PERIOD_W1,zV)-iOpen(NULL,PERIOD_W1,zV)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zV)<iOpen(NULL,PERIOD_W1,zV))
              {
               downshadowzV=MathAbs((iLow(NULL,PERIOD_W1,zV)-iClose(NULL,PERIOD_W1,zV)+(1*Point))/Point);
              }

            BodyzV=MathAbs(iClose(NULL,PERIOD_W1,zV)-iOpen(NULL,PERIOD_W1,zV))/Point;

            int nLL4=zV;
            int MaxNLL4=zV;
            double MaxBodyLL4=zV;
            while(nLL4<(nOfCandleW+zV))
              {
               double BodyLL4=((iOpen(NULL,PERIOD_W1,nLL4)-iClose(NULL,PERIOD_W1,nLL4))/Point);
               double dyLL4=MathAbs(BodyLL4);
               if(dyLL4>MaxBodyLL4)
                 {
                  MaxBodyLL4=dyLL4;
                  MaxNLL4=nLL4;
                 }
               nLL4++;
              }

            int n2LL4=zV;
            int MaxN2LL4=zV;
            double MaxBody2LL4=zV;
            while(n2LL4<(nOfCandleW+zV))
              {
               double Body2LL4=((iOpen(NULL,PERIOD_W1,n2LL4)-iClose(NULL,PERIOD_W1,n2LL4))/Point);
               double dy2LL4=MathAbs(Body2LL4);
               if(dy2LL4<MaxBodyLL4 && dy2LL4>MaxBody2LL4)
                 {
                  MaxBody2LL4=dy2LL4;
                  MaxN2LL4=n2LL4;
                 }
               n2LL4++;
              }

            double darsadLL4=(BodyzV/((MaxBodyLL4+MaxBody2LL4)/2))*100;

            double candlesizeLL4;
            if(darsadLL4>=59)
               candlesizeLL4=4;
            if(darsadLL4<59 && darsadLL4>=39)
               candlesizeLL4=3;
            if(darsadLL4<39 && darsadLL4>5)
               candlesizeLL4=2;
            if(darsadLL4<=5)
               candlesizeLL4=1;

            if(iHigh(NULL,PERIOD_W1,zV)<minLL2-((TL-LL)/variable) && iHigh(NULL,PERIOD_W1,zV)>(minLL2-(TL-LL)) && candlesizeLL4<3 && upshadowzV>=BodyzV)
              {
               LL4=iHigh(NULL,PERIOD_W1,zV);
               if(LL4>minLL4)minLL4=LL4;
               ObjectCreate("ML LL4 Candid W1-"+zV,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zV),iLow(NULL,PERIOD_W1,zV));
               ObjectSet("ML LL4 Candid W1-"+zV,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL4 Candid W1-"+zV,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL4 Candid W1-"+zV,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }
            if(iHigh(NULL,PERIOD_W1,zV)<minLL2-((TL-LL)/variable) && candlesizeLL4>3 && iHigh(NULL,PERIOD_W1,zV)>(minLL2-(TL-LL)) && upshadowzV>=(BodyzV/4))
              {
               LL4=iHigh(NULL,PERIOD_W1,zV);
               if(LL4>minLL4)minLL4=LL4;
               ObjectCreate("ML LL4 Candid W2-"+zV,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zV),iHigh(NULL,PERIOD_W1,zV));
               ObjectSet("ML LL4 Candid W2-"+zV,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL4 Candid W2-"+zV,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL4 Candid W2-"+zV,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }
            if(iHigh(NULL,PERIOD_W1,zV)<minLL2-((TL-LL)/variable) && iHigh(NULL,PERIOD_W1,zV)>minLL2-(TL-LL) && iClose(NULL,PERIOD_W1,zV)>iOpen(NULL,PERIOD_W1,zV) && iLow(NULL,PERIOD_W1,(zV-1))<(iClose(NULL,PERIOD_W1,zV)-(0.45*BodyzV*Point)) && candlesizeLL4>3)
              {
               LL4=iHigh(NULL,PERIOD_W1,zV);
               if(LL4>minLL4)minLL4=LL4;
               ObjectCreate("ML LL4 Candid W3-"+zV,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zV),iHigh(NULL,PERIOD_W1,zV));
               ObjectSet("ML LL4 Candid W3-"+zV,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL4 Candid W3-"+zV,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL4 Candid W3-"+zV,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }

            zV++;
           }

         if(minLL4==minLL2-(TL-LL) || minLL4<=minLL2-((LL-minLL2)/variable2))
           {
            int shoroLVV=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_W1,q));
            ObjectCreate("ML shoroLD1VV-"+shoroLVV,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,shoroLVV-1),iLow(NULL,PERIOD_D1,shoroLVV-1));
            ObjectSet("ML shoroLD1VV-"+shoroLVV,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML shoroLD1VV-"+shoroLVV,OBJPROP_COLOR,Red);
            ObjectSet("ML shoroLD1VV-"+shoroLVV,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);

            int zVV=q;
            int nzVV=q;
            int countVV=0;
            double BodyzVV;
            double upshadowzVV;
            double downshadowzVV;

            while(zVV<(iBars(NULL,PERIOD_D1)-1) && countVV<=MaxTPSLCalc && countVV<=iBars(NULL,PERIOD_D1)-2-zVV)
              {
               if(iClose(NULL,PERIOD_D1,zVV)>iOpen(NULL,PERIOD_D1,zVV))
                 {
                  upshadowzVV=MathAbs((iHigh(NULL,PERIOD_D1,zVV)-iClose(NULL,PERIOD_D1,zVV)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_D1,zVV)<iOpen(NULL,PERIOD_D1,zVV))
                 {
                  upshadowzVV=MathAbs((iHigh(NULL,PERIOD_D1,zVV)-iOpen(NULL,PERIOD_D1,zVV)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_D1,zVV)>iOpen(NULL,PERIOD_D1,zVV))
                 {
                  downshadowzVV=MathAbs((iLow(NULL,PERIOD_D1,zVV)-iOpen(NULL,PERIOD_D1,zVV)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_D1,zVV)<iOpen(NULL,PERIOD_D1,zVV))
                 {
                  downshadowzVV=MathAbs((iLow(NULL,PERIOD_D1,zVV)-iClose(NULL,PERIOD_D1,zVV)+(1*Point))/Point);
                 }

               BodyzVV=MathAbs(iClose(NULL,PERIOD_D1,zVV)-iOpen(NULL,PERIOD_D1,zVV))/Point;

               int nLL4V=zVV;
               int MaxNLL4V=zVV;
               double MaxBodyLL4V=zVV;
               while(nLL4V<(nOfCandleW+zVV))
                 {
                  double BodyLL4V=((iOpen(NULL,PERIOD_D1,nLL4V)-iClose(NULL,PERIOD_D1,nLL4V))/Point);
                  double dyLL4V=MathAbs(BodyLL4V);
                  if(dyLL4V>MaxBodyLL4V)
                    {
                     MaxBodyLL4V=dyLL4V;
                     MaxNLL4V=nLL4V;
                    }
                  nLL4V++;
                 }

               int n2LL4V=zVV;
               int MaxN2LL4V=zVV;
               double MaxBody2LL4V=zVV;
               while(n2LL4V<(nOfCandleW+zVV))
                 {
                  double Body2LL4V=((iOpen(NULL,PERIOD_D1,n2LL4V)-iClose(NULL,PERIOD_D1,n2LL4V))/Point);
                  double dy2LL4V=MathAbs(Body2LL4V);
                  if(dy2LL4V<MaxBodyLL4V && dy2LL4V>MaxBody2LL4V)
                    {
                     MaxBody2LL4V=dy2LL4V;
                     MaxN2LL4V=n2LL4V;
                    }
                  n2LL4V++;
                 }

               double darsadLL4V=(BodyzVV/((MaxBodyLL4V+MaxBody2LL4V)/2))*100;

               double candlesizeLL4V;
               if(darsadLL4V>=59)
                  candlesizeLL4V=4;
               if(darsadLL4V<59 && darsadLL4V>=39)
                  candlesizeLL4V=3;
               if(darsadLL4V<39 && darsadLL4V>5)
                  candlesizeLL4V=2;
               if(darsadLL4V<=5)
                  candlesizeLL4V=1;

               if(iHigh(NULL,PERIOD_D1,zVV)<minLL2-((TL-LL)/variable) && iHigh(NULL,PERIOD_D1,zVV)>minLL2-(TL-LL) && candlesizeLL4V<3 && upshadowzVV>=BodyzVV)
                 {
                  LL4=iHigh(NULL,PERIOD_D1,zVV);
                  if(LL4>minLL4)minLL4=LL4;
                  ObjectCreate("ML LL4V Candid W1-"+zVV,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zVV),iHigh(NULL,PERIOD_D1,zVV));
                  ObjectSet("ML LL4V Candid W1-"+zVV,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL4V Candid W1-"+zVV,OBJPROP_COLOR,Brown);
                  ObjectSet("ML LL4V Candid W1-"+zVV,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                 }
               if(iHigh(NULL,PERIOD_D1,zVV)<minLL2-((TL-LL)/variable) && candlesizeLL4V>3 && iHigh(NULL,PERIOD_D1,zVV)>minLL2-(TL-LL) && upshadowzVV>=(BodyzVV/4))
                 {
                  LL4=iHigh(NULL,PERIOD_D1,zVV);
                  if(LL4>minLL4)minLL4=LL4;
                  ObjectCreate("ML LL4V Candid W2-"+zVV,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zVV),iHigh(NULL,PERIOD_D1,zVV));
                  ObjectSet("ML LL4V Candid W2-"+zVV,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL4V Candid W2-"+zVV,OBJPROP_COLOR,Brown);
                  ObjectSet("ML LL4V Candid W2-"+zVV,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                 }
               if(iHigh(NULL,PERIOD_D1,zVV)<minLL2-((TL-LL)/variable) && iHigh(NULL,PERIOD_D1,zVV)>minLL2-(TL-LL) && iClose(NULL,PERIOD_D1,zVV)>iOpen(NULL,PERIOD_D1,zVV) && iLow(NULL,PERIOD_D1,(zVV-1))<(iClose(NULL,PERIOD_D1,zVV)-(0.45*BodyzVV*Point)) && candlesizeLL4V>3)
                 {
                  LL4=iHigh(NULL,PERIOD_D1,zVV);
                  if(LL4>minLL4)minLL4=LL4;
                  ObjectCreate("ML LL4V Candid W3-"+zVV,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zVV),iHigh(NULL,PERIOD_D1,zVV));
                  ObjectSet("ML LL4V Candid W3-"+zVV,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL4V Candid W3-"+zVV,OBJPROP_COLOR,Brown);
                  ObjectSet("ML LL4V Candid W3-"+zVV,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                 }

               zVV++;
              }

           }

         if(minLL4==minLL2-(TL-LL) || minLL4<=minLL2-((LL-minLL2)/variable2))
           {
            int shoroLVVV=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q));
            ObjectCreate("ML shoroLD1VVV-"+shoroLVVV,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,shoroLVVV-1),iLow(NULL,PERIOD_H4,shoroLVVV-1));
            ObjectSet("ML shoroLD1VVV-"+shoroLVVV,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML shoroLD1VVV-"+shoroLVVV,OBJPROP_COLOR,Red);
            ObjectSet("ML shoroLD1VVV-"+shoroLVVV,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);

            int zVVV=q;
            int nzVVV=q;
            int countVVV=0;
            double BodyzVVV;
            double upshadowzVVV;
            double downshadowzVVV;

            while(zVVV<(iBars(NULL,PERIOD_H4)-1) && countVVV<=MaxTPSLCalc && countVVV<=iBars(NULL,PERIOD_H4)-2-zVVV)
              {
               if(iClose(NULL,PERIOD_H4,zVVV)>iOpen(NULL,PERIOD_H4,zVVV))
                 {
                  upshadowzVVV=MathAbs((iHigh(NULL,PERIOD_H4,zVVV)-iClose(NULL,PERIOD_H4,zVVV)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_H4,zVVV)<iOpen(NULL,PERIOD_H4,zVVV))
                 {
                  upshadowzVVV=MathAbs((iHigh(NULL,PERIOD_H4,zVVV)-iOpen(NULL,PERIOD_H4,zVVV)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_H4,zVVV)>iOpen(NULL,PERIOD_H4,zVVV))
                 {
                  downshadowzVVV=MathAbs((iLow(NULL,PERIOD_H4,zVVV)-iOpen(NULL,PERIOD_H4,zVVV)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_H4,zVVV)<iOpen(NULL,PERIOD_H4,zVVV))
                 {
                  downshadowzVVV=MathAbs((iLow(NULL,PERIOD_H4,zVVV)-iClose(NULL,PERIOD_H4,zVVV)+(1*Point))/Point);
                 }

               BodyzVVV=MathAbs(iClose(NULL,PERIOD_H4,zVVV)-iOpen(NULL,PERIOD_H4,zVVV))/Point;

               int nLL4VV=zVVV;
               int MaxNLL4VV=zVVV;
               double MaxBodyLL4VV=zVVV;
               while(nLL4VV<(nOfCandleW+zVVV))
                 {
                  double BodyLL4VV=((iOpen(NULL,PERIOD_H4,nLL4VV)-iClose(NULL,PERIOD_H4,nLL4VV))/Point);
                  double dyLL4VV=MathAbs(BodyLL4VV);
                  if(dyLL4V>MaxBodyLL4VV)
                    {
                     MaxBodyLL4VV=dyLL4VV;
                     MaxNLL4VV=nLL4VV;
                    }
                  nLL4VV++;
                 }

               int n2LL4VV=zVVV;
               int MaxN2LL4VV=zVVV;
               double MaxBody2LL4VV=zVVV;
               while(n2LL4VV<(nOfCandleW+zVVV))
                 {
                  double Body2LL4VV=((iOpen(NULL,PERIOD_H4,n2LL4VV)-iClose(NULL,PERIOD_H4,n2LL4VV))/Point);
                  double dy2LL4VV=MathAbs(Body2LL4VV);
                  if(dy2LL4VV<MaxBodyLL4VV && dy2LL4VV>MaxBody2LL4VV)
                    {
                     MaxBody2LL4VV=dy2LL4VV;
                     MaxN2LL4VV=n2LL4VV;
                    }
                  n2LL4VV++;
                 }

               double darsadLL4VV=(BodyzVVV/((MaxBodyLL4VV+MaxBody2LL4VV)/2))*100;

               double candlesizeLL4VV;
               if(darsadLL4VV>=59)
                  candlesizeLL4VV=4;
               if(darsadLL4VV<59 && darsadLL4VV>=39)
                  candlesizeLL4VV=3;
               if(darsadLL4VV<39 && darsadLL4VV>5)
                  candlesizeLL4VV=2;
               if(darsadLL4VV<=5)
                  candlesizeLL4VV=1;

               if(iHigh(NULL,PERIOD_H4,zVVV)<minLL2-((TL-LL)/variable) && iHigh(NULL,PERIOD_H4,zVVV)>minLL2-(TL-LL) && candlesizeLL4VV<3 && upshadowzVVV>=BodyzVVV)
                 {
                  LL4=iHigh(NULL,PERIOD_H4,zVVV);
                  if(LL4>minLL4)minLL4=LL4;
                  ObjectCreate("ML LL4VV Candid W1-"+zVVV,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zVVV),iHigh(NULL,PERIOD_H4,zVVV));
                  ObjectSet("ML LL4VV Candid W1-"+zVVV,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL4VV Candid W1-"+zVVV,OBJPROP_COLOR,Brown);
                  ObjectSet("ML LL4VV Candid W1-"+zVVV,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                 }
               if(iHigh(NULL,PERIOD_H4,zVVV)<minLL2-((TL-LL)/variable) && candlesizeLL4VV>3 && iHigh(NULL,PERIOD_H4,zVVV)>minLL2-(TL-LL) && upshadowzVVV>=(BodyzVVV/4))
                 {
                  LL4=iHigh(NULL,PERIOD_H4,zVVV);
                  if(LL4>minLL4)minLL4=LL4;
                  ObjectCreate("ML LL4VV Candid W2-"+zVVV,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zVVV),iHigh(NULL,PERIOD_H4,zVVV));
                  ObjectSet("ML LL4VV Candid W2-"+zVVV,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL4VV Candid W2-"+zVVV,OBJPROP_COLOR,Brown);
                  ObjectSet("ML LL4VV Candid W2-"+zVVV,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                 }
               if(iHigh(NULL,PERIOD_H4,zVVV)<minLL2-((TL-LL)/variable) && iHigh(NULL,PERIOD_H4,zVVV)>minLL2-(TL-LL) && iClose(NULL,PERIOD_H4,zVVV)>iOpen(NULL,PERIOD_H4,zVVV) && iLow(NULL,PERIOD_H4,(zVVV-1))<(iClose(NULL,PERIOD_H4,zVVV)-(0.45*BodyzVVV*Point)) && candlesizeLL4VV>3)
                 {
                  LL4=iHigh(NULL,PERIOD_H4,zVVV);
                  if(LL4>minLL4)minLL4=LL4;
                  ObjectCreate("ML LL4VV Candid W3-"+zVVV,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zVVV),iHigh(NULL,PERIOD_H4,zVVV));
                  ObjectSet("ML LL4VV Candid W3-"+zVVV,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL4VV Candid W3-"+zVVV,OBJPROP_COLOR,Brown);
                  ObjectSet("ML LL4VV Candid W3-"+zVVV,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                 }

               zVVV++;
              }

           }

         //----------Pivot Points Weekly
         pivotpoint =(iHigh(NULL,PERIOD_W1,q)+iClose(NULL,PERIOD_W1,q)+iLow(NULL,PERIOD_W1,q))/3;
         resistant3 = iHigh(NULL,PERIOD_W1,q)+(2*(pivotpoint-iLow(NULL,PERIOD_W1,q)));
         resistant1=2*pivotpoint-iLow(NULL,PERIOD_W1,q);
         support1=2*pivotpoint-iHigh(NULL,PERIOD_W1,q);
         resistant2=pivotpoint+(resistant1-support1);
         support2 = pivotpoint-(resistant1-support1);
         support3 = iLow(NULL,PERIOD_W1,q)- 2*(iHigh(NULL,PERIOD_W1,q)-pivotpoint);

         ObjectCreate("ML pivotpoint",OBJ_HLINE,0,Time[0],pivotpoint,0,0);
         ObjectSet("ML pivotpoint",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_W1|OBJ_PERIOD_H4);
         ObjectSet("ML pivotpoint",OBJPROP_COLOR,DodgerBlue);
         ObjectSet("ML pivotpoint",OBJPROP_WIDTH,1);
         ObjectSet("ML pivotpoint",OBJPROP_STYLE,STYLE_DASHDOT);

         ObjectCreate("ML resistant3",OBJ_HLINE,0,Time[0],resistant3,0,0);
         ObjectSet("ML resistant3",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_W1|OBJ_PERIOD_H4);
         ObjectSet("ML resistant3",OBJPROP_COLOR,DodgerBlue);
         ObjectSet("ML resistant3",OBJPROP_WIDTH,1);
         ObjectSet("ML resistant3",OBJPROP_STYLE,STYLE_DOT);

         ObjectCreate("ML resistant2",OBJ_HLINE,0,Time[0],resistant2,0,0);
         ObjectSet("ML resistant2",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_W1|OBJ_PERIOD_H4);
         ObjectSet("ML resistant2",OBJPROP_COLOR,DodgerBlue);
         ObjectSet("ML resistant2",OBJPROP_WIDTH,1);
         ObjectSet("ML resistant2",OBJPROP_STYLE,STYLE_DOT);

         ObjectCreate("ML resistant1",OBJ_HLINE,0,Time[0],resistant1,0,0);
         ObjectSet("ML resistant1",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_W1|OBJ_PERIOD_H4);
         ObjectSet("ML resistant1",OBJPROP_COLOR,DodgerBlue);
         ObjectSet("ML resistant1",OBJPROP_WIDTH,1);
         ObjectSet("ML resistant1",OBJPROP_STYLE,STYLE_DOT);

         ObjectCreate("ML support1",OBJ_HLINE,0,Time[0],support1,0,0);
         ObjectSet("ML support1",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_W1|OBJ_PERIOD_H4);
         ObjectSet("ML support1",OBJPROP_COLOR,DodgerBlue);
         ObjectSet("ML support1",OBJPROP_WIDTH,1);
         ObjectSet("ML support1",OBJPROP_STYLE,STYLE_DOT);

         ObjectCreate("ML support2",OBJ_HLINE,0,Time[0],support2,0,0);
         ObjectSet("ML support2",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_W1|OBJ_PERIOD_H4);
         ObjectSet("ML support2",OBJPROP_COLOR,DodgerBlue);
         ObjectSet("ML support2",OBJPROP_WIDTH,1);
         ObjectSet("ML support2",OBJPROP_STYLE,STYLE_DOT);

         ObjectCreate("ML support3",OBJ_HLINE,0,Time[0],support3,0,0);
         ObjectSet("ML support3",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_W1|OBJ_PERIOD_H4);
         ObjectSet("ML support3",OBJPROP_COLOR,DodgerBlue);
         ObjectSet("ML support3",OBJPROP_WIDTH,1);
         ObjectSet("ML support3",OBJPROP_STYLE,STYLE_DOT);

         ObjectCreate("ML TL4x",OBJ_HLINE,0,Time[0],minTL4,0,0);
         ObjectSet("ML TL4x",OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1);
         ObjectSet("ML TL4x",OBJPROP_COLOR,Purple);
         ObjectSet("ML TL4x",OBJPROP_WIDTH,1);
         ObjectSet("ML TL4x",OBJPROP_STYLE,STYLE_DASH);
         ObjectCreate("ML TL3x",OBJ_HLINE,0,Time[0],minTL3,0,0);
         ObjectSet("ML TL3x",OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1);
         ObjectSet("ML TL3x",OBJPROP_COLOR,Orange);
         ObjectSet("ML TL3x",OBJPROP_WIDTH,1);
         ObjectSet("ML TL3x",OBJPROP_STYLE,STYLE_DASH);
         ObjectCreate("ML LL3Q",OBJ_HLINE,0,Time[0],minLL3,0,0);
         ObjectSet("ML LL3Q",OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1);
         ObjectSet("ML LL3Q",OBJPROP_COLOR,Orange);
         ObjectSet("ML LL3Q",OBJPROP_WIDTH,1);
         ObjectSet("ML LL3Q",OBJPROP_STYLE,STYLE_DASH);
         ObjectCreate("ML LL4Q",OBJ_HLINE,0,Time[0],minLL4,0,0);
         ObjectSet("ML LL4Q",OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1);
         ObjectSet("ML LL4Q",OBJPROP_COLOR,Purple);
         ObjectSet("ML LL4Q",OBJPROP_WIDTH,1);
         ObjectSet("ML LL4Q",OBJPROP_STYLE,STYLE_DASH);

         //-----------------------------------------/
         int dir=0;
         string direction;
         int cntdir=0;
         int p;
         for(p=k+1;p<=30; p++)
           {
            if(iOpen(NULL,PERIOD_W1,p)<iLow(NULL,PERIOD_W1,k) && cntdir==0)
              {
               direction="صعودی";
               dir=2;
               cntdir=1;
              }
            if(iOpen(NULL,PERIOD_W1,p)>iHigh(NULL,PERIOD_W1,k) && cntdir==0)
              {
               direction="نزولی";
               dir=0;
               cntdir=1;
              }
           }

         //-----------Jadval Tahlil 1   
         string tahlilA;
         string tahlilB;

         if(dir>1 && big>=1 && badaneh2>0)
            tahlilA="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي،شکست حد بال";
         if(dir>1 && big>=1 && badaneh2>0)
            tahlilB="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي، شکست حد پايين";
         if(dir>1 && medium>=1 && badaneh2>0)
            tahlilA="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
         if(dir>1 && medium>=1 && badaneh2>0)
            tahlilB="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
         if(dir>1 && small>=1 && badaneh2>0)
            tahlilA="الگو الف : کاهش تمايلات صعودي ، انتظار عدم نواسانات صعودي، شکست حد پايين";
         if(dir>1 && small>=1 && badaneh2>0)
            tahlilB="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
         if(dir>1 && spinning>=1 && badaneh2>0)
            tahlilA="الگو الف : کاهش تمايلات صعودي ، انتظار عدم نواسانات صعودي، شکست حد پايين";
         if(dir>1 && spinning>=1 && badaneh2>0)
            tahlilB="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";

         if(dir<1 && big>=1 && badaneh2>0)
            tahlilA="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
         if(dir<1 && big>=1 && badaneh2>0)
            tahlilB="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
         if(dir<1 && medium>=1 && badaneh2>0)
            tahlilA="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
         if(dir<1 && medium>=1 && badaneh2>0)
            tahlilB="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
         if(dir<1 && small>=1 && badaneh2>0)
            tahlilA="الگوي الف : شروع تمايلات صعودي ، انتظار نوسانات صعودي ،شکست حد بالا";
         if(dir<1 && small>=1 && badaneh2>0)
            tahlilB="الگوي ب: شروع مجدد تمايلات نزولي،انتظار نوسانات نزولي، شکست حد پايين";
         if(dir<1 && spinning>=1 && badaneh2>0)
            tahlilA="الگوي الف : شروع تمايلات صعودي ، انتظار نوسانات صعودي ،شکست حد بالا";
         if(dir<1 && spinning>=1 && badaneh2>0)
            tahlilB="الگوي ب: شروع مجدد تمايلات نزولي،انتظار نوسانات نزولي، شکست حد پايين";

         if(dir>1 && big>=1 && badaneh>0)
            tahlilA="الگو الف: ادامه تمايلات نزولي ، انتظار نوسانات نزولي، شکست حد پايين";
         if(dir>1 && big>=1 && badaneh>0)
            tahlilB="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
         if(dir>1 && medium>=1 && badaneh>0)
            tahlilA="الگو الف: ادامه تمايلات نزولي ، انتظار نوسانات نزولي، شکست حد پايين ";
         if(dir>1 && medium>=1 && badaneh>0)
            tahlilB="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا ";
         if(dir>1 && small>=1 && badaneh>0)
            tahlilA="الگو الف : شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
         if(dir>1 && small>=1 && badaneh>0)
            tahlilB="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
         if(dir>1 && spinning>=1 && badaneh>0)
            tahlilA="الگو الف : شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
         if(dir>1 && spinning>=1 && badaneh>0)
            tahlilB="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";

         if(dir<1 && big>=1 && badaneh>0)
            tahlilA="الگو الف:ادامه تمايلات نزولي ،انتظار نوسانات نزولي ،شکست حد پايين";
         if(dir<1 && big>=1 && badaneh>0)
            tahlilB="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
         if(dir<1 && medium>=1 && badaneh>0)
            tahlilA="الگو الف:ادامه تمايلات نزولي ،انتظار نوسانات نزولي ،شکست حد پايين";
         if(dir<1 && medium>=1 && badaneh>0)
            tahlilB="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
         if(dir<1 && small>=1 && badaneh>0)
            tahlilA="الگو الف: کاهش تمايلات نزولي ، انتظار عدم نوسانات نزولي ، شکست حد بالا";
         if(dir<1 && small>=1 && badaneh>0)
            tahlilB="الگوي ب: شروع مجدد تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
         if(dir<1 && spinning>=1 && badaneh>0)
            tahlilA="الگو الف: کاهش تمايلات نزولي ، انتظار عدم نوسانات نزولي ، شکست حد بالا";
         if(dir<1 && spinning>=1 && badaneh>0)
            tahlilB="الگوي ب: شروع مجدد تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
        }
      ObjectCreate("ML direction",OBJ_LABEL,0,0,0,0,0);
      ObjectSet("ML direction",OBJPROP_CORNER,0);
      ObjectSet("ML direction",OBJPROP_XDISTANCE,1000);
      ObjectSet("ML direction",OBJPROP_YDISTANCE,20);
      ObjectSetText("ML direction",direction,12,"arial",Blue);

      ObjectCreate("ML candletype",OBJ_LABEL,0,0,0,0,0);
      ObjectSet("ML candletype",OBJPROP_CORNER,0);
      ObjectSet("ML candletype",OBJPROP_XDISTANCE,1000);
      ObjectSet("ML candletype",OBJPROP_YDISTANCE,35);
      ObjectSetText("ML candletype",candletype,12,"arial",Blue);

      ObjectCreate("ML X",OBJ_LABEL,0,0,0,0,0);
      ObjectSet("ML X",OBJPROP_CORNER,0);
      ObjectSet("ML X",OBJPROP_XDISTANCE,1000);
      ObjectSet("ML X",OBJPROP_YDISTANCE,50);
      ObjectSetText("ML X",X,12,"arial",Blue);

      Comment("   جهت اوليه","   ",direction,"\n","   نوع کندل","   ",candletype,"\n","   ","\n  اندازه بدنه کندل مورد ارزيابي:","   ",(badaneh+badaneh2),"\n","  اندازه سايه بالا","     ",upshadow,"\n","  اندازه سايه پايين","    ",downshadow,"\n","\n ميانگين دو بزرگترين کندل محيط","   ",(MaxBody+MaxBody2)/2,"\n   شماره بزرگترين کندل محيط:","   ",MaxN,"\n   شماره دومين کندل بزرگ محيط:","   ",MaxN2,"\n  نسبت بدنه کندل مورد ارزيابي به بدنه مبنا:","   ",Totaldarsad,"\n","  نوع کندل","   ",X,"\n","\n","   حد احتياط بالا","   ",TL,"\n","   حد احتياط پايين","   ",LL,"\n","\n",tahlilA,"\n",tahlilB);
      //--- create timer
      EventSetTimer(7200);
     }
//------------------------Monthly----------------------------------------
   if(typeofanalysis==3)
     {
      double Omonthly= iOpen(NULL,PERIOD_MN1,q);
      double Cmonthly= iClose(NULL,PERIOD_MN1,q);
      if(Cmonthly<Omonthly)
        {
         badanehmonthly=(Omonthly-Cmonthly)/Point;
        }
      if(Cmonthly>Omonthly)
        {
         badaneh2monthly=(Cmonthly-Omonthly)/Point;
        }
      if(nOfCandleWmonthly>iBars(NULL,PERIOD_W1))
        {
         Alert("تعداد کندل اشتباه است");
         return(-1);
        }

      bool upshadowlenghtmonthly;
      bool downshadowlenghtmonthly;
      double upshadowmonthly;
      double downshadowmonthly;

      if(badanehmonthly>0)
         candletypemonthly="عرضه";
      if(badaneh2monthly>0)
         candletypemonthly="تقاضا";

      int nmonthly=q;
      int MaxNmonthly=q;
      double MaxBodymonthly=q;
      while(nmonthly<(nOfCandleWmonthly+q))
        {
         double Bodymonthly=((iOpen(NULL,PERIOD_MN1,nmonthly)-iClose(NULL,PERIOD_MN1,nmonthly))/Point);
         double dymonthly=MathAbs(Bodymonthly);
         if(dymonthly>MaxBodymonthly)
           {
            MaxBodymonthly=dymonthly;
            MaxNmonthly=nmonthly;
           }
         nmonthly++;
        }

      int n2monthly=q;
      int MaxN2monthly=q;
      double MaxBody2monthly=q;
      while(n2monthly<(nOfCandleWmonthly+q))
        {
         double Body2monthly=((iOpen(NULL,PERIOD_MN1,n2monthly)-iClose(NULL,PERIOD_MN1,n2monthly))/Point);
         double dy2monthly=MathAbs(Body2monthly);
         if(dy2monthly<MaxBodymonthly && dy2monthly>MaxBody2monthly)
           {
            MaxBody2monthly=dy2monthly;
            MaxN2monthly=n2monthly;
           }
         n2monthly++;
        }

      double darsadmonthly=(badanehmonthly/((MaxBodymonthly+MaxBody2monthly)/2))*100;
      double darsad2monthly=(badaneh2monthly/((MaxBodymonthly+MaxBody2monthly)/2))*100;
      double Totaldarsadmonthly=(darsadmonthly+darsad2monthly);

      bool bigmonthly=0;
      bool mediummonthly=0;
      bool smallmonthly=0;
      bool spinningmonthly=0;
      string Xmonthly;

      if(Totaldarsadmonthly>=59)
         Xmonthly="بزرگ";
      if(Totaldarsadmonthly<59 && Totaldarsadmonthly>=39)
         Xmonthly="متوسط";
      if(Totaldarsadmonthly<39 && Totaldarsadmonthly>5)
         Xmonthly="کوچک";
      if(Totaldarsadmonthly<=5)
         Xmonthly="اسپينينگ";
      if(Totaldarsadmonthly>=59)
        {
         bigmonthly=1;
         candlesizemonthly=4;
        }
      if(Totaldarsadmonthly<59 && Totaldarsadmonthly>=39)
        {
         mediummonthly=1;
         candlesizemonthly=3;
        }
      if(Totaldarsadmonthly<39 && Totaldarsadmonthly>5)
        {
         smallmonthly=1;
         candlesizemonthly=2;
        }
      if(Totaldarsadmonthly<=5)
        {
         spinningmonthly=1;
         candlesizemonthly=1;
        }

      if(badaneh2monthly>0)
        {
         upshadowmonthly=MathAbs((iHigh(NULL,PERIOD_MN1,q)-iClose(NULL,PERIOD_MN1,q)+(1*Point))/Point);
         downshadowmonthly=MathAbs((iOpen(NULL,PERIOD_MN1,q)-iLow(NULL,PERIOD_MN1,q)+(1*Point))/Point);
        }
      if(badanehmonthly>0)
        {
         upshadowmonthly=MathAbs((iHigh(NULL,PERIOD_MN1,q)-iOpen(NULL,PERIOD_MN1,q)+(1*Point))/Point);
         downshadowmonthly=MathAbs((iClose(NULL,PERIOD_MN1,q)-iLow(NULL,PERIOD_MN1,q)+(1*Point))/Point);
        }

      int dirmonthly=0;
      string directionmonthly;
      int cntdirmonthly=0;
      int pmonthly;
      for(pmonthly=k+1;pmonthly<=30; pmonthly++)
        {
         if(iOpen(NULL,PERIOD_MN1,pmonthly)<iLow(NULL,PERIOD_MN1,k) && cntdirmonthly==0)
           {
            directionmonthly="صعودی";
            dirmonthly=2;
            cntdirmonthly=1;
           }
         if(iOpen(NULL,PERIOD_MN1,pmonthly)>iHigh(NULL,PERIOD_MN1,k) && cntdirmonthly==0)
           {
            directionmonthly="نزولی";
            dirmonthly=0;
            cntdirmonthly=1;
           }
        }

      if(upshadowmonthly>101 && upshadowmonthly>(1.5*(badaneh2monthly+badanehmonthly)) && candlesizemonthly<3)
         upshadowlenghtmonthly=1;
      if(upshadowmonthly>101 && upshadowmonthly>(1*(badaneh2monthly+badanehmonthly)) && candlesizemonthly>=3)
         upshadowlenghtmonthly=1;

      if(downshadowmonthly>101 && downshadowmonthly>(1.5*(badaneh2monthly+badanehmonthly)) && candlesizemonthly<3)
         downshadowlenghtmonthly=1;
      if(downshadowmonthly>101 && downshadowmonthly>(1*(badaneh2monthly+badanehmonthly)) && candlesizemonthly>=3)
         downshadowlenghtmonthly=1;

      if(upshadowlenghtmonthly==1 && downshadowlenghtmonthly==1 && 0.9<(upshadowmonthly/downshadowmonthly) && (upshadowmonthly/downshadowmonthly)<1.1)
        {
         Comment(upshadowmonthly/downshadowmonthly);
         Alert("This Month is doutfull!! you should not trade on this symbol");
         return (-1);
        }

      if(bigmonthly>=1 && badaneh2monthly>0)
         TLmonthly=iHigh(NULL,PERIOD_MN1,q);
      if(bigmonthly>=1 && badaneh2monthly>0)
         LLmonthly=(iOpen(NULL,PERIOD_MN1,q)+(0.75*(badaneh2monthly*Point)));

      if(upshadowlenghtmonthly==1 && bigmonthly>=1 && badaneh2monthly>0)
         TLmonthly=iHigh(NULL,PERIOD_MN1,q)-(0.5*(upshadowmonthly*Point));

      if(bigmonthly>=1 && badanehmonthly>0)
         LLmonthly=iLow(NULL,PERIOD_MN1,q);
      if(bigmonthly>=1 && badanehmonthly>0)
         TLmonthly=(iClose(NULL,PERIOD_MN1,q)+(0.25*(badanehmonthly*Point)));
      if(downshadowlenghtmonthly==1 && bigmonthly>=1 && badanehmonthly>0)
         LLmonthly=iLow(NULL,PERIOD_MN1,q)+(0.5*(downshadowmonthly*Point));

      if(mediummonthly==1 && badanehmonthly>0)
         LLmonthly=iLow(NULL,PERIOD_MN1,q);
      if(mediummonthly==1 && badanehmonthly>0)
         TLmonthly=(iClose(NULL,PERIOD_MN1,q)+(0.5*(badanehmonthly*Point)));

      if(downshadowlenghtmonthly==1 && mediummonthly==1 && badanehmonthly>0)
         LLmonthly=iLow(NULL,PERIOD_MN1,q)+(0.5*(downshadowmonthly*Point));

      if(mediummonthly==1 && badaneh2monthly>0)
         TLmonthly=iHigh(NULL,PERIOD_MN1,q);
      if(mediummonthly==1 && badaneh2monthly>0)
         LLmonthly=(iOpen(NULL,PERIOD_MN1,q)+(0.5*(badaneh2monthly*Point)));

      if(upshadowlenghtmonthly==1 && mediummonthly==1 && badaneh2monthly>0)
         TLmonthly=iHigh(NULL,PERIOD_MN1,q) -(0.5*(upshadowmonthly*Point));

      if(smallmonthly==1 && badaneh2monthly>0 && spinningmonthly==0)
         TLmonthly=iHigh(NULL,PERIOD_MN1,q);
      if(smallmonthly==1 && badaneh2monthly>0 && spinningmonthly==0)
         LLmonthly=iLow(NULL,PERIOD_MN1,q);

      if(upshadowlenghtmonthly==1 && smallmonthly==1 && badaneh2monthly>0 && spinningmonthly==0)
         TLmonthly=iHigh(NULL,PERIOD_MN1,q) -(0.5*(upshadowmonthly*Point));
      if(downshadowlenghtmonthly==1 && smallmonthly==1 && badaneh2monthly>0 && spinningmonthly==0)
         LLmonthly=iLow(NULL,PERIOD_MN1,q)+(0.5*(downshadowmonthly*Point));

      if(smallmonthly==1 && badanehmonthly>0 && spinningmonthly==0)
         LLmonthly=iLow(NULL,PERIOD_MN1,q);
      if(smallmonthly==1 && badanehmonthly>0 && spinningmonthly==0)
         TLmonthly=iHigh(NULL,PERIOD_MN1,q);

      if(downshadowlenghtmonthly==1 && smallmonthly==1 && badanehmonthly>0 && spinningmonthly==0)
         LLmonthly=iClose(NULL,PERIOD_MN1,q)-(0.5*(downshadowmonthly*Point));
      if(upshadowlenghtmonthly==1 && smallmonthly==1 && badanehmonthly>0 && spinningmonthly==0)
         TLmonthly=iOpen(NULL,PERIOD_MN1,q)+(0.5*(upshadowmonthly*Point));

      if(spinningmonthly==1 && badaneh2monthly>0)
         TLmonthly=iHigh(NULL,PERIOD_MN1,q);
      if(spinningmonthly==1 && badaneh2monthly>0)
         LLmonthly=iLow(NULL,PERIOD_MN1,q);

      if(spinningmonthly==1 && upshadowlenghtmonthly==1 && badaneh2monthly>0)
         TLmonthly=iHigh(NULL,PERIOD_MN1,q) -(0.5*(upshadowmonthly*Point));
      if(spinningmonthly==1 && downshadowlenghtmonthly==1 && badaneh2monthly>0)
         LLmonthly=iLow(NULL,PERIOD_MN1,q)+(0.5*(downshadowmonthly*Point));

      if(spinningmonthly==1 && badanehmonthly>0)
         LLmonthly=iLow(NULL,PERIOD_MN1,q);
      if(spinningmonthly==1 && badanehmonthly>0)
         TLmonthly=iHigh(NULL,PERIOD_MN1,q);

      if(spinningmonthly==1 && downshadowlenghtmonthly==1 && badanehmonthly>0)
         LLmonthly=iClose(NULL,PERIOD_MN1,q)-(0.5*(downshadowmonthly*Point));
      if(spinningmonthly==1 && upshadowlenghtmonthly==1 && badanehmonthly>0)
         TLmonthly=iOpen(NULL,PERIOD_MN1,q)+(0.5*(upshadowmonthly*Point));

      double MinLimitmonthly;
      if(candlesizemonthly==4) MinLimitmonthly=MinRateBmonthly*(((NormalizeDouble(TLmonthly,Digits)-NormalizeDouble(LLmonthly,Digits)))/6);
      if(candlesizemonthly==3) MinLimitmonthly=MinRateMmonthly*(((NormalizeDouble(TLmonthly,Digits)-NormalizeDouble(LLmonthly,Digits)))/6);
      if(candlesizemonthly==2) MinLimitmonthly=MinRateSmonthly*(((NormalizeDouble(TLmonthly,Digits)-NormalizeDouble(LLmonthly,Digits)))/6);
      if(candlesizemonthly==1) MinLimitmonthly=MinRateSPmonthly*(((NormalizeDouble(TLmonthly,Digits)-NormalizeDouble(LLmonthly,Digits)))/6);

      double safetylimitUmonthly=MathMax((TLmonthly+(MinLimit2monthly*Point)),(TLmonthly+MinLimitmonthly));
      double safetylimitDmonthly=MathMin((LLmonthly-(MinLimit2monthly*Point)),(LLmonthly-MinLimitmonthly));


      int zmonthly=q;
      int nzmonthly=q;
      minTL2monthly=TLmonthly+((TLmonthly-LLmonthly)*2);
      minLL2monthly=LLmonthly-((TLmonthly-LLmonthly)*2);
      minTL2Smonthly=TLmonthly+((TLmonthly-LLmonthly)*4);
      minLL2Smonthly=LLmonthly-((TLmonthly-LLmonthly)*4);
      int countmonthly=0;
      bool mohitimonthly;
      double Bodyzmonthly;
      double upshadowzmonthly;
      double downshadowzmonthly;

      while(zmonthly<(iBars(NULL,PERIOD_MN1)-1) && countmonthly<=MaxTPSLCalcmonthly && countmonthly<=iBars(NULL,PERIOD_MN1)-2-zmonthly)
        {
           {
            if(iHigh(NULL,PERIOD_MN1,zmonthly)>LLmonthly && iLow(NULL,PERIOD_MN1,zmonthly)<TLmonthly)
              {
               mohitimonthly=1;
               countmonthly++;
               ObjectCreate("ML MohitiTW-"+zmonthly,OBJ_ARROW_CHECK,0,iTime(NULL,PERIOD_MN1,zmonthly),iLow(NULL,PERIOD_MN1,zmonthly));
               ObjectSet("ML MohitiTW-"+zmonthly,OBJPROP_COLOR,Purple);
               ObjectSet("ML MohitiTW-"+zmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
              }
            else mohitimonthly=0;
           }

         if(mohitimonthly==1)
           {
            if((iHigh(NULL,PERIOD_MN1,zmonthly)>TLmonthly && iOpen(NULL,PERIOD_MN1,zmonthly)<TLmonthly))
              {

               if(iClose(NULL,PERIOD_MN1,zmonthly)>iOpen(NULL,PERIOD_MN1,zmonthly))
                 {
                  upshadowzmonthly=MathAbs((iHigh(NULL,PERIOD_MN1,zmonthly)-iClose(NULL,PERIOD_MN1,zmonthly)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_MN1,zmonthly)<iOpen(NULL,PERIOD_MN1,zmonthly))
                 {
                  upshadowzmonthly=MathAbs((iHigh(NULL,PERIOD_MN1,zmonthly)-iOpen(NULL,PERIOD_MN1,zmonthly)+(1*Point))/Point);
                 }

               Bodyzmonthly=MathAbs(iClose(NULL,PERIOD_MN1,zmonthly)-iOpen(NULL,PERIOD_MN1,zmonthly))/Point;
               int nTL2monthly=zmonthly;
               int MaxNTL2monthly=zmonthly;
               double MaxBodyTL2monthly=zmonthly;
               while(nTL2monthly<(nOfCandleWmonthly+zmonthly))
                 {
                  double BodyTL2monthly=((iOpen(NULL,PERIOD_MN1,nTL2monthly)-iClose(NULL,PERIOD_MN1,nTL2monthly))/Point);
                  double dyTL2monthly=MathAbs(BodyTL2monthly);
                  if(dyTL2monthly>MaxBodyTL2monthly)
                    {
                     MaxBodyTL2monthly=dyTL2monthly;
                     MaxNTL2monthly=nTL2monthly;
                    }
                  nTL2monthly++;
                 }

               int n2TL2monthly=zmonthly;
               int MaxN2TL2monthly=zmonthly;
               double MaxBody2TL2monthly=zmonthly;
               while(n2TL2monthly<(nOfCandleWmonthly+zmonthly))
                 {
                  double Body2TL2monthly=((iOpen(NULL,PERIOD_MN1,n2TL2monthly)-iClose(NULL,PERIOD_MN1,n2TL2monthly))/Point);
                  double dy2TL2monthly=MathAbs(Body2TL2monthly);
                  if(dy2TL2monthly<MaxBodyTL2monthly && dy2TL2monthly>MaxBody2TL2monthly)
                    {
                     MaxBody2TL2monthly=dy2TL2monthly;
                     MaxN2TL2monthly=n2TL2monthly;
                    }
                  n2TL2monthly++;
                 }

               double darsadTL2monthly=(Bodyzmonthly/((MaxBodyTL2monthly+MaxBody2TL2monthly)/2))*100;

               double candlesizeTL2monthly;
               if(darsadTL2monthly>=59)
                  candlesizeTL2monthly=4;
               if(darsadTL2monthly<59 && darsadTL2monthly>=39)
                  candlesizeTL2monthly=3;
               if(darsadTL2monthly<39 && darsadTL2monthly>5)
                  candlesizeTL2monthly=2;
               if(darsadTL2monthly<=5)
                  candlesizeTL2monthly=1;

               if(iClose(NULL,PERIOD_MN1,zmonthly)<TLmonthly && candlesizeTL2monthly>=3 && upshadowzmonthly>=Bodyzmonthly && iHigh(NULL,PERIOD_MN1,zmonthly)>(TLmonthly+(MinLimitmonthly)))
                 {
                  TL2monthly=iHigh(NULL,PERIOD_MN1,zmonthly);
                  if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                  ObjectCreate("ML TL2 Candid W1-"+zmonthly,OBJ_VLINE,0,iTime(NULL,PERIOD_MN1,zmonthly),iOpen(NULL,PERIOD_MN1,zmonthly));
                  ObjectSet("ML TL2 Candid W1-"+zmonthly,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL2 Candid W1-"+zmonthly,OBJPROP_COLOR,Blue);
                  ObjectSet("ML TL2 Candid W1-"+zmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
                 }

               if(iClose(NULL,PERIOD_MN1,zmonthly)<TLmonthly && candlesizeTL2monthly<3 && upshadowzmonthly>=(2*Bodyzmonthly) && iHigh(NULL,PERIOD_MN1,zmonthly)>(TLmonthly+(MinLimitmonthly)))
                 {
                  TL2monthly=iHigh(NULL,PERIOD_MN1,zmonthly);
                  if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                  ObjectCreate("ML TL2 Candid W2-"+zmonthly,OBJ_VLINE,0,iTime(NULL,PERIOD_MN1,zmonthly),iOpen(NULL,PERIOD_MN1,zmonthly));
                  ObjectSet("ML TL2 Candid W2-"+zmonthly,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL2 Candid W2-"+zmonthly,OBJPROP_COLOR,Blue);
                  ObjectSet("ML TL2 Candid W2-"+zmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
                 }

               if(iClose(NULL,PERIOD_MN1,zmonthly)<TLmonthly && candlesizeTL2monthly>=3 && iHigh(NULL,PERIOD_MN1,zmonthly)>(TLmonthly+(MinLimitmonthly)) && (iClose(NULL,PERIOD_MN1,zmonthly)<iOpen(NULL,PERIOD_MN1,zmonthly)))
                 {
                  TL2monthly=iHigh(NULL,PERIOD_MN1,zmonthly);
                  if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                  ObjectCreate("ML TL2 Candid W3-"+zmonthly,OBJ_VLINE,0,iTime(NULL,PERIOD_MN1,zmonthly),iOpen(NULL,PERIOD_MN1,zmonthly));
                  ObjectSet("ML TL2 Candid W3-"+zmonthly,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL2 Candid W3-"+zmonthly,OBJPROP_COLOR,Blue);
                  ObjectSet("ML TL2 Candid W3-"+zmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);

                 }

               if(zmonthly>q && iClose(NULL,PERIOD_MN1,zmonthly)>TLmonthly && candlesizeTL2monthly>=3 && iHigh(NULL,PERIOD_MN1,zmonthly)>(TLmonthly+(MinLimitmonthly)) && iLow(NULL,PERIOD_MN1,(zmonthly-1))<(iClose(NULL,PERIOD_MN1,zmonthly)-(0.45*(iClose(NULL,PERIOD_MN1,zmonthly)-iOpen(NULL,PERIOD_MN1,zmonthly)))))
                 {
                  TL2monthly=MathMax(iHigh(NULL,PERIOD_MN1,zmonthly),iHigh(NULL,PERIOD_MN1,(zmonthly-1)));
                  if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                  ObjectCreate("ML TL2 Candid W4-"+zmonthly,OBJ_VLINE,0,iTime(NULL,PERIOD_MN1,zmonthly),iOpen(NULL,PERIOD_MN1,zmonthly));
                  ObjectSet("ML TL2 Candid W4-"+zmonthly,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL2 Candid W4-"+zmonthly,OBJPROP_COLOR,Blue);
                  ObjectSet("ML TL2 Candid W4-"+zmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);

                 }

              }

            if(((iLow(NULL,PERIOD_MN1,zmonthly)<LLmonthly && iOpen(NULL,PERIOD_MN1,zmonthly)>LLmonthly)))
              {

               if(iClose(NULL,PERIOD_MN1,zmonthly)>iOpen(NULL,PERIOD_MN1,zmonthly))
                 {
                  downshadowzmonthly=MathAbs((iLow(NULL,PERIOD_MN1,zmonthly)-iOpen(NULL,PERIOD_MN1,zmonthly)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_MN1,zmonthly)<iOpen(NULL,PERIOD_MN1,zmonthly))
                 {
                  downshadowzmonthly=MathAbs((iLow(NULL,PERIOD_MN1,zmonthly)-iClose(NULL,PERIOD_MN1,zmonthly)+(1*Point))/Point);
                 }

               Bodyzmonthly=MathAbs(iClose(NULL,PERIOD_MN1,zmonthly)-iOpen(NULL,PERIOD_MN1,zmonthly))/Point;
               int nLL2monthly=zmonthly;
               int MaxNLL2monthly=zmonthly;
               double MaxBodyLL2monthly=zmonthly;
               while(nLL2monthly<(nOfCandleWmonthly+zmonthly))
                 {
                  double BodyLL2monthly=((iOpen(NULL,PERIOD_MN1,nLL2monthly)-iClose(NULL,PERIOD_MN1,nLL2monthly))/Point);
                  double dyLL2monthly=MathAbs(BodyLL2monthly);
                  if(dyLL2monthly>MaxBodyLL2monthly)
                    {
                     MaxBodyLL2monthly=dyLL2monthly;
                     MaxNLL2monthly=nLL2monthly;
                    }
                  nLL2monthly++;
                 }

               int n2LL2monthly=zmonthly;
               int MaxN2LL2monthly=zmonthly;
               double MaxBody2LL2monthly=zmonthly;
               while(n2LL2monthly<(nOfCandleWmonthly+zmonthly))
                 {
                  double Body2LL2monthly=((iOpen(NULL,PERIOD_MN1,n2LL2monthly)-iClose(NULL,PERIOD_MN1,n2LL2monthly))/Point);
                  double dy2LL2monthly=MathAbs(Body2LL2monthly);
                  if(dy2LL2monthly<MaxBodyLL2monthly && dy2LL2monthly>MaxBody2LL2monthly)
                    {
                     MaxBody2LL2monthly=dy2LL2monthly;
                     MaxN2LL2monthly=n2LL2monthly;
                    }
                  n2LL2monthly++;
                 }

               double darsadLL2monthly=(Bodyzmonthly/((MaxBodyLL2monthly+MaxBody2LL2monthly)/2))*100;

               double candlesizeLL2monthly;
               if(darsadLL2monthly>=59)
                  candlesizeLL2monthly=4;
               if(darsadLL2monthly<59 && darsadLL2monthly>=39)
                  candlesizeLL2monthly=3;
               if(darsadLL2monthly<39 && darsadLL2monthly>5)
                  candlesizeLL2monthly=2;
               if(darsadLL2monthly<=5)
                  candlesizeLL2monthly=1;

               if(iClose(NULL,PERIOD_MN1,zmonthly)>LLmonthly && candlesizeLL2monthly>=3 && downshadowzmonthly>=Bodyzmonthly && iLow(NULL,PERIOD_MN1,zmonthly)<(LLmonthly-(MinLimitmonthly)))
                 {
                  LL2monthly=iLow(NULL,PERIOD_MN1,zmonthly);

                  if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                  ObjectCreate("ML LL2 Candid W1-"+zmonthly,OBJ_VLINE,0,iTime(NULL,PERIOD_MN1,zmonthly),iOpen(NULL,PERIOD_MN1,zmonthly));
                  ObjectSet("ML LL2 Candid W1-"+zmonthly,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL2 Candid W1-"+zmonthly,OBJPROP_COLOR,Red);
                  ObjectSet("ML LL2 Candid W1-"+zmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);

                 }

               if(iClose(NULL,PERIOD_MN1,zmonthly)>LLmonthly && candlesizeLL2monthly<3 && downshadowzmonthly>=(2*Bodyzmonthly) && iLow(NULL,PERIOD_MN1,zmonthly)<(LLmonthly-(MinLimitmonthly)))
                 {

                  LL2monthly=iLow(NULL,PERIOD_MN1,zmonthly);

                  if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                  ObjectCreate("ML LL2 Candid W2-"+zmonthly,OBJ_VLINE,0,iTime(NULL,PERIOD_MN1,zmonthly),iOpen(NULL,PERIOD_MN1,zmonthly));
                  ObjectSet("ML LL2 Candid W2-"+zmonthly,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL2 Candid W2-"+zmonthly,OBJPROP_COLOR,Red);
                  ObjectSet("ML LL2 Candid W2-"+zmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);

                 }

               if(iClose(NULL,PERIOD_MN1,zmonthly)>LLmonthly && candlesizeLL2monthly>=3 && iLow(NULL,PERIOD_MN1,zmonthly)<(LLmonthly-(MinLimitmonthly)) && (iClose(NULL,PERIOD_MN1,zmonthly)>iOpen(NULL,PERIOD_MN1,zmonthly)))
                 {
                  LL2monthly=iLow(NULL,PERIOD_MN1,zmonthly);

                  if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                  ObjectCreate("ML LL2 Candid W3-"+zmonthly,OBJ_VLINE,0,iTime(NULL,PERIOD_MN1,zmonthly),iOpen(NULL,PERIOD_MN1,zmonthly));
                  ObjectSet("ML LL2 Candid W3-"+zmonthly,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL2 Candid W3-"+zmonthly,OBJPROP_COLOR,Red);
                  ObjectSet("ML LL2 Candid W3-"+zmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);

                 }

               if(zmonthly>q && iClose(NULL,PERIOD_MN1,zmonthly)<LLmonthly && candlesizeLL2monthly>=3 && iLow(NULL,PERIOD_MN1,zmonthly)<(LLmonthly-(MinLimitmonthly)) && iHigh(NULL,PERIOD_MN1,(zmonthly-1))>(iClose(NULL,PERIOD_MN1,zmonthly)+(0.45*(iOpen(NULL,PERIOD_MN1,zmonthly)-iClose(NULL,PERIOD_MN1,zmonthly)))))
                 {
                  LL2monthly=MathMin(iLow(NULL,PERIOD_MN1,zmonthly),iLow(NULL,PERIOD_MN1,(zmonthly-1)));
                  if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                  ObjectCreate("ML LL2 Candid W4"+zmonthly,OBJ_VLINE,0,iTime(NULL,PERIOD_MN1,zmonthly),iOpen(NULL,PERIOD_MN1,zmonthly));
                  ObjectSet("ML LL2 Candid W4"+zmonthly,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL2 Candid W4"+zmonthly,OBJPROP_COLOR,Red);
                  ObjectSet("ML LL2 Candid W4"+zmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);

                 }

              }
           }
         zmonthly++;
        }

      if(minTL2monthly==TLmonthly+((TLmonthly-LLmonthly)*2))
        {
         int shoroTmonthly=iBarShift(NULL,PERIOD_W1,iTime(NULL,PERIOD_MN1,q));
         ObjectCreate("ML ShoroTD1-"+shoroTmonthly,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,shoroTmonthly-1),0);
         ObjectSet("ML ShoroTD1-"+shoroTmonthly,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML ShoroTD1-"+shoroTmonthly,OBJPROP_COLOR,Purple);
         ObjectSet("ML ShoroTD1-"+shoroTmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);

         int z2monthly=shoroTmonthly;
         int nz2monthly=shoroTmonthly;
         int count2monthly=0;
         bool mohiti2monthly;
         double Bodyz2monthly;
         double upshadowz2monthly;

         while(z2monthly<(iBars(NULL,PERIOD_W1)-1) && count2monthly<=MaxTPSLCalcmonthly && count2monthly<=iBars(NULL,PERIOD_W1)-2-z2monthly)
           {
              {
               if(iHigh(NULL,PERIOD_W1,z2monthly)>LLmonthly && iLow(NULL,PERIOD_W1,z2monthly)<TLmonthly)
                 {
                  mohiti2monthly=1;
                  count2monthly++;
                  ObjectCreate("ML MohitiTD1T-"+z2monthly,OBJ_ARROW_CHECK,0,iTime(NULL,PERIOD_W1,z2monthly),iOpen(NULL,PERIOD_W1,z2monthly));
                  ObjectSet("ML MohitiTD1T-"+z2monthly,OBJPROP_COLOR,Blue);
                  ObjectSet("ML MohitiTD1T-"+z2monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                 }
               else mohiti2monthly=0;
              }

            if(mohiti2monthly==1)
              {
               if((iHigh(NULL,PERIOD_W1,z2monthly)>TLmonthly && iOpen(NULL,PERIOD_W1,z2monthly)<TLmonthly))
                 {
                  if(iClose(NULL,PERIOD_W1,z2monthly)>iOpen(NULL,PERIOD_W1,z2monthly))
                    {
                     upshadowz2monthly=MathAbs((iHigh(NULL,PERIOD_W1,z2monthly)-iClose(NULL,PERIOD_W1,z2monthly)+(1*Point))/Point);
                    }
                  if(iClose(NULL,PERIOD_W1,z2monthly)<iOpen(NULL,PERIOD_W1,z2monthly))
                    {
                     upshadowz2monthly=MathAbs((iHigh(NULL,PERIOD_W1,z2monthly)-iOpen(NULL,PERIOD_W1,z2monthly)+(1*Point))/Point);
                    }

                  Bodyz2monthly=MathAbs(iClose(NULL,PERIOD_W1,z2monthly)-iOpen(NULL,PERIOD_W1,z2monthly))/Point;
                  int nTL22monthly=z2monthly;
                  int MaxNTL22monthly=z2monthly;
                  double MaxBodyTL22monthly=z2monthly;
                  while(nTL22monthly<(nOfCandleWmonthly+z2monthly))
                    {
                     double BodyTL22monthly=((iOpen(NULL,PERIOD_W1,nTL22monthly)-iClose(NULL,PERIOD_W1,nTL22monthly))/Point);
                     double dyTL22monthly=MathAbs(BodyTL22monthly);
                     if(dyTL22monthly>MaxBodyTL22monthly)
                       {
                        MaxBodyTL22monthly=dyTL22monthly;
                        MaxNTL22monthly=nTL22monthly;
                       }
                     nTL22monthly++;
                    }

                  int n2TL22monthly=z2monthly;
                  int MaxN2TL22monthly=z2monthly;
                  double MaxBody2TL22monthly=z2monthly;
                  while(n2TL22monthly<(nOfCandleWmonthly+z2monthly))
                    {
                     double Body2TL22monthly=((iOpen(NULL,PERIOD_W1,n2TL22monthly)-iClose(NULL,PERIOD_W1,n2TL22monthly))/Point);
                     double dy2TL22monthly=MathAbs(Body2TL22monthly);
                     if(dy2TL22monthly<MaxBodyTL22monthly && dy2TL22monthly>MaxBody2TL22monthly)
                       {
                        MaxBody2TL22monthly=dy2TL22monthly;
                        MaxN2TL22monthly=n2TL22monthly;
                       }
                     n2TL22monthly++;
                    }

                  double darsadTL22monthly=(Bodyz2monthly/((MaxBodyTL22monthly+MaxBody2TL22monthly)/2))*100;

                  double candlesizeTL22monthly;
                  if(darsadTL22monthly>=59)
                     candlesizeTL22monthly=4;
                  if(darsadTL22monthly<59 && darsadTL22monthly>=39)
                     candlesizeTL22monthly=3;
                  if(darsadTL22monthly<39 && darsadTL22monthly>5)
                     candlesizeTL22monthly=2;
                  if(darsadTL22monthly<=5)
                     candlesizeTL22monthly=1;

                  if(iClose(NULL,PERIOD_W1,z2monthly)<TLmonthly && candlesizeTL22monthly>=3 && upshadowz2monthly>=Bodyz2monthly && iHigh(NULL,PERIOD_W1,z2monthly)>(TLmonthly+(MinLimitmonthly)))
                    {
                     TL2monthly=iHigh(NULL,PERIOD_W1,z2monthly);
                     if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                     ObjectCreate("ML TL2 Candid D11-"+z2monthly,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,z2monthly),iOpen(NULL,PERIOD_W1,z2monthly));
                     ObjectSet("ML TL2 Candid D11-"+z2monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML TL2 Candid D11-"+z2monthly,OBJPROP_COLOR,Blue);
                     ObjectSet("ML TL2 Candid D11-"+z2monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }

                  if(iClose(NULL,PERIOD_W1,z2monthly)<TLmonthly && candlesizeTL22monthly<3 && upshadowz2monthly>=(2*Bodyz2monthly) && iHigh(NULL,PERIOD_W1,z2monthly)>(TLmonthly+(MinLimitmonthly)))
                    {
                     TL2monthly=iHigh(NULL,PERIOD_W1,z2monthly);
                     if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                     ObjectCreate("ML TL2 Candid D12-"+z2monthly,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,z2monthly),iOpen(NULL,PERIOD_W1,z2monthly));
                     ObjectSet("ML TL2 Candid D12-"+z2monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML TL2 Candid D12-"+z2monthly,OBJPROP_COLOR,Blue);
                     ObjectSet("ML TL2 Candid D12-"+z2monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                  if(iClose(NULL,PERIOD_W1,z2monthly)<TLmonthly && candlesizeTL22monthly>=3 && iHigh(NULL,PERIOD_W1,z2monthly)>(TLmonthly+(MinLimitmonthly)) && (iClose(NULL,PERIOD_W1,z2monthly)<iOpen(NULL,PERIOD_W1,z2monthly)))
                    {
                     TL2monthly=iHigh(NULL,PERIOD_W1,z2monthly);
                     if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                     ObjectCreate("TL2 Candid D13-"+z2monthly,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,z2monthly),iOpen(NULL,PERIOD_W1,z2monthly));
                     ObjectSet("TL2 Candid D13-"+z2monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("TL2 Candid D13-"+z2monthly,OBJPROP_COLOR,Blue);
                     ObjectSet("TL2 Candid D13-"+z2monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                  if(z2monthly>shoroTmonthly && iClose(NULL,PERIOD_W1,z2monthly)>TLmonthly && candlesizeTL22monthly>=3 && iHigh(NULL,PERIOD_W1,z2monthly)>(TLmonthly+(MinLimitmonthly)) && iLow(NULL,PERIOD_W1,(z2monthly-1))<(iClose(NULL,PERIOD_W1,z2monthly)-(0.45*(iClose(NULL,PERIOD_W1,z2monthly)-iOpen(NULL,PERIOD_W1,z2monthly)))))
                    {
                     TL2monthly=MathMax(iHigh(NULL,PERIOD_W1,z2monthly),iHigh(NULL,PERIOD_W1,(z2monthly-1)));
                     if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                     ObjectCreate("ML TL2 Candid D14-"+z2monthly,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,z2monthly),iOpen(NULL,PERIOD_W1,z2monthly));
                     ObjectSet("ML TL2 Candid D14-"+z2monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML TL2 Candid D14-"+z2monthly,OBJPROP_COLOR,Blue);
                     ObjectSet("ML TL2 Candid D14-"+z2monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                 }

              }
            z2monthly++;
           }

        }
      if(minTL2monthly==TLmonthly+((TLmonthly-LLmonthly)*2))
        {
         int shoroT2monthly=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q));
         ObjectCreate("ML shoroTH4T-"+shoroT2monthly,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,shoroT2monthly-1),iLow(NULL,PERIOD_D1,shoroT2monthly-1));
         ObjectSet("ML shoroTH4T-"+shoroT2monthly,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroTH4T-"+shoroT2monthly,OBJPROP_COLOR,Red);
         ObjectSet("ML shoroTH4T-"+shoroT2monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);

         int z4monthly=shoroT2monthly;
         int nz4monthly=shoroT2monthly;
         int count4monthly=0;
         bool mohiti4monthly;
         double Bodyz4monthly;
         double upshadowz4monthly;

         while(z4monthly<(iBars(NULL,PERIOD_D1)-1) && count4monthly<=MaxTPSLCalcmonthly && count4monthly<=iBars(NULL,PERIOD_D1)-2-z4monthly)
           {
              {
               if(iHigh(NULL,PERIOD_D1,z4monthly)>LLmonthly && iLow(NULL,PERIOD_D1,z4monthly)<TLmonthly)
                 {
                  mohiti4monthly=1;
                  count4monthly++;
                  ObjectCreate("ML MohitiTH4T-"+z4monthly,OBJ_ARROW_CHECK,0,iTime(NULL,PERIOD_D1,z4monthly),iOpen(NULL,PERIOD_D1,z4monthly));
                  ObjectSet("ML MohitiTH4T-"+z4monthly,OBJPROP_COLOR,Blue);
                  ObjectSet("ML MohitiTH4T-"+z4monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                 }
               else mohiti4monthly=0;
              }

            if(mohiti4monthly==1)
              {
               if((iHigh(NULL,PERIOD_D1,z4monthly)>TLmonthly && iOpen(NULL,PERIOD_D1,z4monthly)<TLmonthly))
                 {
                  if(iClose(NULL,PERIOD_D1,z4monthly)>iOpen(NULL,PERIOD_D1,z4monthly))
                    {
                     upshadowz4monthly=MathAbs((iHigh(NULL,PERIOD_D1,z4monthly)-iClose(NULL,PERIOD_D1,z4monthly)+(1*Point))/Point);
                    }
                  if(iClose(NULL,PERIOD_D1,z4monthly)<iOpen(NULL,PERIOD_D1,z4monthly))
                    {
                     upshadowz4monthly=MathAbs((iHigh(NULL,PERIOD_D1,z4monthly)-iOpen(NULL,PERIOD_D1,z4monthly)+(1*Point))/Point);
                    }

                  Bodyz4monthly=MathAbs(iClose(NULL,PERIOD_D1,z4monthly)-iOpen(NULL,PERIOD_D1,z4monthly))/Point;
                  int nTL24monthly=z4monthly;
                  int MaxNTL24monthly=z4monthly;
                  double MaxBodyTL24monthly=z4monthly;
                  while(nTL24monthly<(nOfCandleWmonthly+z4monthly))
                    {
                     double BodyTL24monthly=((iOpen(NULL,PERIOD_D1,nTL24monthly)-iClose(NULL,PERIOD_D1,nTL24monthly))/Point);
                     double dyTL24monthly=MathAbs(BodyTL24monthly);
                     if(dyTL24monthly>MaxBodyTL24monthly)
                       {
                        MaxBodyTL24monthly=dyTL24monthly;
                        MaxNTL24monthly=nTL24monthly;
                       }
                     nTL24monthly++;
                    }

                  int n2TL24monthly=z4monthly;
                  int MaxN2TL24monthly=z4monthly;
                  double MaxBody2TL24monthly=z4monthly;
                  while(n2TL24monthly<(nOfCandleWmonthly+z4monthly))
                    {
                     double Body2TL24monthly=((iOpen(NULL,PERIOD_D1,n2TL24monthly)-iClose(NULL,PERIOD_D1,n2TL24monthly))/Point);
                     double dy2TL24monthly=MathAbs(Body2TL24monthly);
                     if(dy2TL24monthly<MaxBodyTL24monthly && dy2TL24monthly>MaxBody2TL24monthly)
                       {
                        MaxBody2TL24monthly=dy2TL24monthly;
                        MaxN2TL24monthly=n2TL24monthly;
                       }
                     n2TL24monthly++;
                    }

                  double darsadTL24monthly=(Bodyz4monthly/((MaxBodyTL24monthly+MaxBody2TL24monthly)/2))*100;

                  double candlesizeTL24monthly;
                  if(darsadTL24monthly>=61)
                     candlesizeTL24monthly=4;
                  if(darsadTL24monthly<61 && darsadTL24monthly>=41)
                     candlesizeTL24monthly=3;
                  if(darsadTL24monthly<41 && darsadTL24monthly>5)
                     candlesizeTL24monthly=2;
                  if(darsadTL24monthly<=5)
                     candlesizeTL24monthly=1;

                  if(iClose(NULL,PERIOD_D1,z4monthly)<TLmonthly && candlesizeTL24monthly>=3 && upshadowz4monthly>=Bodyz4monthly && iHigh(NULL,PERIOD_D1,z4monthly)>(TLmonthly+(MinLimitmonthly)))
                    {
                     TL2monthly=iHigh(NULL,PERIOD_D1,z4monthly);
                     if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                     ObjectCreate("ML TL2 Candid H41-"+z4monthly,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,z4monthly),iOpen(NULL,PERIOD_D1,z4monthly));
                     ObjectSet("ML TL2 Candid H41-"+z4monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML TL2 Candid H41-"+z4monthly,OBJPROP_COLOR,Blue);
                     ObjectSet("ML TL2 Candid H41-"+z4monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }

                  if(iClose(NULL,PERIOD_D1,z4monthly)<TLmonthly && candlesizeTL24monthly<3 && upshadowz4monthly>=(2*Bodyz4monthly) && iHigh(NULL,PERIOD_D1,z4monthly)>(TLmonthly+(MinLimitmonthly)))
                    {
                     TL2monthly=iHigh(NULL,PERIOD_D1,z4monthly);
                     if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                     ObjectCreate("ML TL2 Candid H42-"+z4monthly,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,z4monthly),iOpen(NULL,PERIOD_D1,z4monthly));
                     ObjectSet("ML TL2 Candid H42-"+z4monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML TL2 Candid H42-"+z4monthly,OBJPROP_COLOR,Blue);
                     ObjectSet("ML TL2 Candid H42-"+z4monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }

                  if(iClose(NULL,PERIOD_D1,z4monthly)<TLmonthly && candlesizeTL24monthly>=3 && iHigh(NULL,PERIOD_D1,z4monthly)>(TLmonthly+(MinLimitmonthly)) && (iClose(NULL,PERIOD_D1,z4monthly)<iOpen(NULL,PERIOD_D1,z4monthly)))
                    {
                     TL2monthly=iHigh(NULL,PERIOD_D1,z4monthly);
                     if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                     ObjectCreate("ML TL2 Candid H43-"+z4monthly,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,z4monthly),iOpen(NULL,PERIOD_D1,z4monthly));
                     ObjectSet("ML TL2 Candid H43-"+z4monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML TL2 Candid H43-"+z4monthly,OBJPROP_COLOR,Blue);
                     ObjectSet("ML TL2 Candid H43-"+z4monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }

                  if(z4monthly>shoroT2monthly && iClose(NULL,PERIOD_D1,z4monthly)>TLmonthly && candlesizeTL24monthly>=3 && iHigh(NULL,PERIOD_D1,z4monthly)>(TLmonthly+(MinLimitmonthly)) && iLow(NULL,PERIOD_D1,(z4monthly-1))<(iClose(NULL,PERIOD_D1,z4monthly)-(0.45*(iClose(NULL,PERIOD_D1,z4monthly)-iOpen(NULL,PERIOD_D1,z4monthly)))))
                    {
                     TL2monthly=MathMax(iHigh(NULL,PERIOD_D1,z4monthly),iHigh(NULL,PERIOD_D1,(z4monthly-1)));
                     if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                     ObjectCreate("ML TL2 Candid H44-"+z4monthly,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,z4monthly),iOpen(NULL,PERIOD_D1,z4monthly));
                     ObjectSet("ML ML TL2 Candid H44-"+z4monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML TL2 Candid H44-"+z4monthly,OBJPROP_COLOR,Blue);
                     ObjectSet("ML TL2 Candid H44-"+z4monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }

                 }

              }
            z4monthly++;
           }

        }

      if(minLL2monthly==LLmonthly-((TLmonthly-LLmonthly)*2))
        {
         int shoroLmonthly=iBarShift(NULL,PERIOD_W1,iTime(NULL,PERIOD_MN1,q));
         ObjectCreate("ML shoroLD1-"+shoroLmonthly,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,shoroLmonthly-1),iLow(NULL,PERIOD_W1,shoroLmonthly-1));
         ObjectSet("ML shoroLD1-"+shoroLmonthly,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroLD1-"+shoroLmonthly,OBJPROP_COLOR,Purple);
         ObjectSet("ML shoroLD1-"+shoroLmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);

         int z3monthly=shoroLmonthly;
         int nz3monthly=shoroLmonthly;
         int count3monthly=0;
         bool mohiti3monthly;
         double Bodyz3monthly;
         double downshadowz3monthly;

         while(z3monthly<(iBars(NULL,PERIOD_W1)-1) && count3monthly<=MaxTPSLCalcmonthly && count3monthly<=iBars(NULL,PERIOD_W1)-2-z3monthly)
           {
              {
               if(iHigh(NULL,PERIOD_W1,z3monthly)>LLmonthly && iLow(NULL,PERIOD_W1,z3monthly)<TLmonthly)
                 {
                  mohiti3monthly=1;
                  count3monthly++;
                  ObjectCreate("ML MohitiTD1L-"+z3monthly,OBJ_ARROW_CHECK,0,iTime(NULL,PERIOD_W1,z3monthly),iOpen(NULL,PERIOD_W1,z3monthly));
                  ObjectSet("ML MohitiTD1L-"+z3monthly,OBJPROP_COLOR,Blue);
                  ObjectSet("ML MohitiTD1L-"+z3monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                 }
               else mohiti3monthly=0;
              }

            if(mohiti3monthly==1)
              {

               if(((iLow(NULL,PERIOD_W1,z3monthly)<LLmonthly && iOpen(NULL,PERIOD_W1,z3monthly)>LLmonthly)))
                 {

                  if(iClose(NULL,PERIOD_W1,z3monthly)>iOpen(NULL,PERIOD_W1,z3monthly))
                    {
                     downshadowz3monthly=MathAbs((iLow(NULL,PERIOD_W1,z3monthly)-iOpen(NULL,PERIOD_W1,z3monthly)+(1*Point))/Point);
                    }
                  if(iClose(NULL,PERIOD_W1,z3monthly)<iOpen(NULL,PERIOD_W1,z3monthly))
                    {
                     downshadowz3monthly=MathAbs((iLow(NULL,PERIOD_W1,z3monthly)-iClose(NULL,PERIOD_W1,z3monthly)+(1*Point))/Point);
                    }

                  Bodyz3monthly=MathAbs(iClose(NULL,PERIOD_W1,z3monthly)-iOpen(NULL,PERIOD_W1,z3monthly))/Point;
                  int nLL23monthly=z3monthly;
                  int MaxNLL23monthly=z3monthly;
                  double MaxBodyLL23monthly=z3monthly;
                  while(nLL23monthly<(nOfCandleWmonthly+z3monthly))
                    {
                     double BodyLL23monthly=((iOpen(NULL,PERIOD_W1,nLL23monthly)-iClose(NULL,PERIOD_W1,nLL23monthly))/Point);
                     double dyLL23monthly=MathAbs(BodyLL23monthly);
                     if(dyLL23monthly>MaxBodyLL23monthly)
                       {
                        MaxBodyLL23monthly=dyLL23monthly;
                        MaxNLL23monthly=nLL23monthly;
                       }
                     nLL23monthly++;
                    }

                  int n2LL23monthly=z3monthly;
                  int MaxN2LL23monthly=z3monthly;
                  double MaxBody2LL23monthly=z3monthly;
                  while(n2LL23monthly<(nOfCandleWmonthly+z3monthly))
                    {
                     double Body2LL23monthly=((iOpen(NULL,PERIOD_W1,n2LL23monthly)-iClose(NULL,PERIOD_W1,n2LL23monthly))/Point);
                     double dy2LL23monthly=MathAbs(Body2LL23monthly);
                     if(dy2LL23monthly<MaxBodyLL23monthly && dy2LL23monthly>MaxBody2LL23monthly)
                       {
                        MaxBody2LL23monthly=dy2LL23monthly;
                        MaxN2LL23monthly=n2LL23monthly;
                       }
                     n2LL23monthly++;
                    }

                  double darsadLL23monthly=(Bodyz3monthly/((MaxBodyLL23monthly+MaxBody2LL23monthly)/2))*100;

                  double candlesizeLL23monthly;
                  if(darsadLL23monthly>=59)
                     candlesizeLL23monthly=4;
                  if(darsadLL23monthly<59 && darsadLL23monthly>=39)
                     candlesizeLL23monthly=3;
                  if(darsadLL23monthly<39 && darsadLL23monthly>5)
                     candlesizeLL23monthly=2;
                  if(darsadLL23monthly<=5)
                     candlesizeLL23monthly=1;

                  if(iClose(NULL,PERIOD_W1,z3monthly)>LLmonthly && candlesizeLL23monthly>=3 && downshadowz3monthly>=Bodyz3monthly && iLow(NULL,PERIOD_W1,z3monthly)<(LLmonthly-(MinLimitmonthly)))
                    {
                     LL2monthly=iLow(NULL,PERIOD_W1,z3monthly);
                     if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                     ObjectCreate("ML LL2 Candid LD11-"+z3monthly,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,z3monthly),iOpen(NULL,PERIOD_W1,z3monthly));
                     ObjectSet("ML LL2 Candid LD11-"+z3monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid LD11-"+z3monthly,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid LD11-"+z3monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                  if(iClose(NULL,PERIOD_W1,z3monthly)>LLmonthly && candlesizeLL23monthly<3 && downshadowz3monthly>=(2*Bodyz3monthly) && iLow(NULL,PERIOD_W1,z3monthly)<(LLmonthly-(MinLimitmonthly)))
                    {
                     LL2monthly=iLow(NULL,PERIOD_W1,z3monthly);
                     if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                     ObjectCreate("ML LL2 Candid LD12-"+z3monthly,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,z3monthly),iOpen(NULL,PERIOD_W1,z3monthly));
                     ObjectSet("ML LL2 Candid LD12-"+z3monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid LD12-"+z3monthly,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid LD12-"+z3monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                  if(iClose(NULL,PERIOD_W1,z3monthly)>LLmonthly && candlesizeLL23monthly>=3 && iLow(NULL,PERIOD_W1,z3monthly)<(LLmonthly-(MinLimitmonthly)) && (iClose(NULL,PERIOD_W1,z3monthly)>iOpen(NULL,PERIOD_W1,z3monthly)))
                    {
                     LL2monthly=iLow(NULL,PERIOD_W1,z3monthly);
                     if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                     ObjectCreate("ML LL2 Candid LD13-"+z3monthly,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,z3monthly),iOpen(NULL,PERIOD_W1,z3monthly));
                     ObjectSet("ML LL2 Candid LD13-"+z3monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid LD13-"+z3monthly,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid LD13-"+z3monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                  if(z3monthly>shoroLmonthly && iClose(NULL,PERIOD_W1,z3monthly)<LLmonthly && candlesizeLL23monthly>=3 && iLow(NULL,PERIOD_W1,z3monthly)<(LLmonthly-(MinLimitmonthly)) && iHigh(NULL,PERIOD_W1,(z3monthly-1))>(iClose(NULL,PERIOD_W1,z3monthly)+(0.45*(iOpen(NULL,PERIOD_W1,z3monthly)-iClose(NULL,PERIOD_W1,z3monthly)))))
                    {
                     LL2monthly=MathMin(iLow(NULL,PERIOD_W1,z3monthly),iLow(NULL,PERIOD_W1,(z3monthly-1)));
                     if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                     ObjectCreate("ML LL2 Candid LD14-"+z3monthly,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,z3monthly),iOpen(NULL,PERIOD_W1,z3monthly));
                     ObjectSet("ML LL2 Candid LD14-"+z3monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid LD14-"+z3monthly,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid LD14-"+z3monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                 }
              }
            z3monthly++;
           }

        }

      if(minLL2monthly==LLmonthly-((TLmonthly-LLmonthly)*2))
        {
         int shoroL2monthly=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q));
         ObjectCreate("shoroLH4L-"+shoroL2monthly,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,shoroL2monthly-1),iLow(NULL,PERIOD_D1,shoroL2monthly-1));
         ObjectSet("shoroLH4L-"+shoroL2monthly,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("shoroLH4L-"+shoroL2monthly,OBJPROP_COLOR,Purple);
         ObjectSet("shoroLH4L-"+shoroL2monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);

         int z5monthly=shoroL2monthly;
         int nz5monthly=shoroL2monthly;
         int count5monthly=0;
         bool mohiti5monthly;
         double Bodyz5monthly;
         double downshadowz5monthly;

         while(z5monthly<(iBars(NULL,PERIOD_D1)-1) && count5monthly<=MaxTPSLCalcmonthly && count5monthly<=iBars(NULL,PERIOD_D1)-2-z5monthly)
           {
              {
               if(iHigh(NULL,PERIOD_D1,z5monthly)>LLmonthly && iLow(NULL,PERIOD_D1,z5monthly)<TLmonthly)
                 {
                  mohiti5monthly=1;
                  count5monthly++;
                  ObjectCreate("MohitiTH4-"+z5monthly,OBJ_ARROW_CHECK,0,iTime(NULL,PERIOD_D1,z5monthly),iOpen(NULL,PERIOD_D1,z5monthly));
                  ObjectSet("MohitiTH4-"+z5monthly,OBJPROP_COLOR,Blue);
                  ObjectSet("MohitiTH4-"+z5monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                 }
               else mohiti5monthly=0;
              }

            if(mohiti5monthly==1)
              {

               if(((iLow(NULL,PERIOD_D1,z5monthly)<LLmonthly && iOpen(NULL,PERIOD_D1,z5monthly)>LLmonthly)))
                 {

                  if(iClose(NULL,PERIOD_D1,z5monthly)>iOpen(NULL,PERIOD_D1,z5monthly))
                    {
                     downshadowz5monthly=MathAbs((iLow(NULL,PERIOD_D1,z5monthly)-iOpen(NULL,PERIOD_D1,z5monthly)+(1*Point))/Point);
                    }
                  if(iClose(NULL,PERIOD_D1,z5monthly)<iOpen(NULL,PERIOD_D1,z5monthly))
                    {
                     downshadowz5monthly=MathAbs((iLow(NULL,PERIOD_D1,z5monthly)-iClose(NULL,PERIOD_D1,z5monthly)+(1*Point))/Point);
                    }

                  Bodyz5monthly=MathAbs(iClose(NULL,PERIOD_D1,z5monthly)-iOpen(NULL,PERIOD_D1,z5monthly))/Point;
                  int nLL25monthly=z5monthly;
                  int MaxNLL25monthly=z5monthly;
                  double MaxBodyLL25monthly=z5monthly;
                  while(nLL25monthly<(nOfCandleWmonthly+z5monthly))
                    {
                     double BodyLL25monthly=((iOpen(NULL,PERIOD_D1,nLL25monthly)-iClose(NULL,PERIOD_D1,nLL25monthly))/Point);
                     double dyLL25monthly=MathAbs(BodyLL25monthly);
                     if(dyLL25monthly>MaxBodyLL25monthly)
                       {
                        MaxBodyLL25monthly=dyLL25monthly;
                        MaxNLL25monthly=nLL25monthly;
                       }
                     nLL25monthly++;
                    }

                  int n2LL25monthly=z5monthly;
                  int MaxN2LL25monthly=z5monthly;
                  double MaxBody2LL25monthly=z5monthly;
                  while(n2LL25monthly<(nOfCandleWmonthly+z5monthly))
                    {
                     double Body2LL25monthly=((iOpen(NULL,PERIOD_D1,n2LL25monthly)-iClose(NULL,PERIOD_D1,n2LL25monthly))/Point);
                     double dy2LL25monthly=MathAbs(Body2LL25monthly);
                     if(dy2LL25monthly<MaxBodyLL25monthly && dy2LL25monthly>MaxBody2LL25monthly)
                       {
                        MaxBody2LL25monthly=dy2LL25monthly;
                        MaxN2LL25monthly=n2LL25monthly;
                       }
                     n2LL25monthly++;
                    }

                  double darsadLL25monthly=(Bodyz5monthly/((MaxBodyLL25monthly+MaxBody2LL25monthly)/2))*100;

                  double candlesizeLL25monthly;
                  if(darsadLL25monthly>=61)
                     candlesizeLL25monthly=4;
                  if(darsadLL25monthly<61 && darsadLL25monthly>=41)
                     candlesizeLL25monthly=3;
                  if(darsadLL25monthly<41 && darsadLL25monthly>5)
                     candlesizeLL25monthly=2;
                  if(darsadLL25monthly<=5)
                     candlesizeLL25monthly=1;

                  if(iClose(NULL,PERIOD_D1,z5monthly)>LLmonthly && candlesizeLL25monthly>=3 && downshadowz5monthly>=Bodyz5monthly && iLow(NULL,PERIOD_D1,z5monthly)<(LLmonthly-(MinLimitmonthly)))
                    {
                     LL2monthly=iLow(NULL,PERIOD_D1,z5monthly);
                     if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                     ObjectCreate("ML LL2 Candid LH41-"+z5monthly,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,z5monthly),iOpen(NULL,PERIOD_D1,z5monthly));
                     ObjectSet("ML LL2 Candid LH41-"+z5monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid LH41-"+z5monthly,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid LH41-"+z5monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }

                  if(iClose(NULL,PERIOD_D1,z5monthly)>LLmonthly && candlesizeLL25monthly<3 && downshadowz5monthly>=(2*Bodyz5monthly) && iLow(NULL,PERIOD_D1,z5monthly)<(LLmonthly-(MinLimitmonthly)))
                    {
                     LL2monthly=iLow(NULL,PERIOD_D1,z5monthly);
                     if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                     ObjectCreate("ML LL2 Candid LH42-"+z5monthly,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,z5monthly),iOpen(NULL,PERIOD_D1,z5monthly));
                     ObjectSet("ML LL2 Candid LH42-"+z5monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid LH42-"+z5monthly,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid LH42-"+z5monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }

                  if(iClose(NULL,PERIOD_D1,z5monthly)>LLmonthly && candlesizeLL25monthly>=3 && iLow(NULL,PERIOD_D1,z5monthly)<(LLmonthly-(MinLimitmonthly)) && (iClose(NULL,PERIOD_D1,z5monthly)>iOpen(NULL,PERIOD_D1,z5monthly)))
                    {
                     LL2monthly=iLow(NULL,PERIOD_D1,z5monthly);
                     if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                     ObjectCreate("ML LL2 Candid LH43-"+z5monthly,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,z5monthly),iOpen(NULL,PERIOD_D1,z5monthly));
                     ObjectSet("ML LL2 Candid LH43-"+z5monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid LH43-"+z5monthly,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid LH43-"+z5monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }

                  if(z5monthly>shoroL2monthly && iClose(NULL,PERIOD_D1,z5monthly)<LLmonthly && candlesizeLL25monthly>=3 && iLow(NULL,PERIOD_D1,z5monthly)<(LLmonthly-(MinLimitmonthly)) && iHigh(NULL,PERIOD_D1,(z5monthly-1))>(iClose(NULL,PERIOD_D1,z5monthly)+(0.45*(iOpen(NULL,PERIOD_D1,z5monthly)-iClose(NULL,PERIOD_D1,z5monthly)))))
                    {
                     LL2monthly=MathMin(iLow(NULL,PERIOD_D1,z5monthly),iLow(NULL,PERIOD_D1,(z5monthly-1)));
                     if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                     ObjectCreate("ML LL2 Candid LH44-"+z5monthly,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,z5monthly),iOpen(NULL,PERIOD_D1,z5monthly));
                     ObjectSet("ML LL2 Candid LH44-"+z5monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid LH44-"+z5monthly,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid LH44-"+z5monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }

                 }
              }
            z5monthly++;
           }

        }
      int cntTmonthly,cntLmonthly;
      if(minTL2monthly==TLmonthly+((TLmonthly-LLmonthly)*2) && cntTmonthly==0)
        {
         Alert(Symbol(),"حد دوم بالا یافت نشد");
         if(minLL2monthly!=LLmonthly-((TLmonthly-LLmonthly)*2))
           {
            minTL2monthly=TLmonthly+(LLmonthly-minLL2monthly);
           }
         cntTmonthly=1;
        }
      if(minLL2monthly==LLmonthly-((TLmonthly-LLmonthly)*2) && cntLmonthly==0)
        {
         Alert(Symbol(),"حد دوم پایین یافت نشد");
         if(minTL2monthly!=TLmonthly+((TLmonthly-LLmonthly)*2))
           {
            minLL2monthly=LLmonthly-(minTL2monthly-TLmonthly);
           }
         cntLmonthly=1;
        }

      ObjectCreate("ML Start-"+q,OBJ_VLINE,0,iTime(NULL,PERIOD_MN1,q-1),0);
      ObjectSet("ML Start-"+q,OBJPROP_STYLE,STYLE_SOLID);
      ObjectSet("ML Start-"+q,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
      ObjectSet("ML Start-"+q,OBJPROP_COLOR,Black);
      ObjectSet("ML Start-"+q,OBJPROP_WIDTH,2);

      ObjectCreate("ML End-"+q,OBJ_VLINE,0,iTime(NULL,PERIOD_MN1,q-2),0);
      ObjectSet("ML End-"+q,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
      ObjectSet("ML End-"+q,OBJPROP_STYLE,STYLE_SOLID);
      ObjectSet("ML End-"+q,OBJPROP_COLOR,Black);
      ObjectSet("ML End-"+q,OBJPROP_WIDTH,2);

      ObjectCreate("ML TL",OBJ_HLINE,0,Time[0],TLmonthly,0,0);
      ObjectSet("ML TL",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_M30);
      ObjectCreate("ML TL2",OBJ_HLINE,0,Time[0],minTL2monthly,0,0);
      ObjectSet("ML TL2",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_M30);

      ObjectCreate("ML LL",OBJ_HLINE,0,Time[0],LLmonthly,0,0);
      ObjectSet("ML LL",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_M30);
      ObjectCreate("ML LL2",OBJ_HLINE,0,Time[0],minLL2monthly,0,0);
      ObjectSet("ML LL2",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_M30);

      ObjectSet("ML TL",OBJPROP_COLOR,Orange);
      ObjectSet("ML TL",OBJPROP_WIDTH,2);
      ObjectSet("ML LL",OBJPROP_COLOR,Orange);
      ObjectSet("ML LL",OBJPROP_WIDTH,2);
      ObjectSet("ML TL2",OBJPROP_COLOR,Purple);
      ObjectSet("ML TL2",OBJPROP_WIDTH,1);
      ObjectSet("ML LL2",OBJPROP_COLOR,Purple);
      ObjectSet("ML LL2",OBJPROP_WIDTH,1);

      Firstinlinemonthly=LLmonthly+((TLmonthly-LLmonthly)/3);
      Secondinlinemonthly=LLmonthly+((TLmonthly-LLmonthly)/3);
      Middleinlinemonthly=LLmonthly+((TLmonthly-LLmonthly)/2);


      ObjectCreate("ML First 0.33",OBJ_HLINE,0,Time[0],Middleinlinemonthly,0,0);
      ObjectSet("ML First 0.33",OBJPROP_STYLE,STYLE_DASH);
      ObjectSet("ML First 0.33",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_M30);
      ObjectSet("ML First 0.33",OBJPROP_COLOR,Black);

      //----------------------------------------/

      int zXmonthly=q;
      int nzXmonthly=q;
      int countXmonthly=0;
      double BodyzXmonthly;
      double upshadowzXmonthly;
      double downshadowzXmonthly;
      minTL4monthly=minTL2monthly+(TLmonthly-LLmonthly);

      while(zXmonthly<(iBars(NULL,PERIOD_MN1)-1) && countXmonthly<=MaxTPSLCalcmonthly && countXmonthly<=iBars(NULL,PERIOD_MN1)-2-zXmonthly)
        {
         if(iClose(NULL,PERIOD_MN1,zXmonthly)>iOpen(NULL,PERIOD_MN1,zXmonthly))
           {
            upshadowzXmonthly=MathAbs((iHigh(NULL,PERIOD_MN1,zXmonthly)-iClose(NULL,PERIOD_MN1,zXmonthly)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_MN1,zXmonthly)<iOpen(NULL,PERIOD_MN1,zXmonthly))
           {
            upshadowzXmonthly=MathAbs((iHigh(NULL,PERIOD_MN1,zXmonthly)-iOpen(NULL,PERIOD_MN1,zXmonthly)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_MN1,zXmonthly)>iOpen(NULL,PERIOD_MN1,zXmonthly))
           {
            downshadowzXmonthly=MathAbs((iLow(NULL,PERIOD_MN1,zXmonthly)-iOpen(NULL,PERIOD_MN1,zXmonthly)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_MN1,zXmonthly)<iOpen(NULL,PERIOD_MN1,zXmonthly))
           {
            downshadowzXmonthly=MathAbs((iLow(NULL,PERIOD_MN1,zXmonthly)-iClose(NULL,PERIOD_MN1,zXmonthly)+(1*Point))/Point);
           }

         BodyzXmonthly=MathAbs(iClose(NULL,PERIOD_MN1,zXmonthly)-iOpen(NULL,PERIOD_MN1,zXmonthly))/Point;

         int nTL4monthly=zXmonthly;
         int MaxNTL4monthly=zXmonthly;
         double MaxBodyTL4monthly=zXmonthly;
         while(nTL4monthly<(nOfCandleWmonthly+zXmonthly))
           {
            double BodyTL4monthly=((iOpen(NULL,PERIOD_MN1,nTL4monthly)-iClose(NULL,PERIOD_MN1,nTL4monthly))/Point);
            double dyTL4monthly=MathAbs(BodyTL4monthly);
            if(dyTL4monthly>MaxBodyTL4monthly)
              {
               MaxBodyTL4monthly=dyTL4monthly;
               MaxNTL4monthly=nTL4monthly;
              }
            nTL4monthly++;
           }

         int n2TL4monthly=zXmonthly;
         int MaxN2TL4monthly=zXmonthly;
         double MaxBody2TL4monthly=zXmonthly;
         while(n2TL4monthly<(nOfCandleWmonthly+zXmonthly))
           {
            double Body2TL4monthly=((iOpen(NULL,PERIOD_MN1,n2TL4monthly)-iClose(NULL,PERIOD_MN1,n2TL4monthly))/Point);
            double dy2TL4monthly=MathAbs(Body2TL4monthly);
            if(dy2TL4monthly<MaxBodyTL4monthly && dy2TL4monthly>MaxBody2TL4monthly)
              {
               MaxBody2TL4monthly=dy2TL4monthly;
               MaxN2TL4monthly=n2TL4monthly;
              }
            n2TL4monthly++;
           }

         double darsadTL4monthly=(BodyzXmonthly/((MaxBodyTL4monthly+MaxBody2TL4monthly)/2))*100;

         double candlesizeTL4monthly;
         if(darsadTL4monthly>=59)
            candlesizeTL4monthly=4;
         if(darsadTL4monthly<59 && darsadTL4monthly>=39)
            candlesizeTL4monthly=3;
         if(darsadTL4monthly<39 && darsadTL4monthly>5)
            candlesizeTL4monthly=2;
         if(darsadTL4monthly<=5)
            candlesizeTL4monthly=1;

         if(iLow(NULL,PERIOD_MN1,zXmonthly)>minTL2monthly && iLow(NULL,PERIOD_MN1,zXmonthly)<minTL2monthly+(TLmonthly-LLmonthly) && candlesizeTL4monthly<3 && downshadowzXmonthly>=BodyzXmonthly)
           {
            TL4monthly=iLow(NULL,PERIOD_MN1,zXmonthly);
            if(TL4monthly<minTL4monthly)minTL4monthly=TL4monthly;
            ObjectCreate("ML TL4 Candid W1monthly-"+zXmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_MN1,zXmonthly),iHigh(NULL,PERIOD_MN1,zXmonthly));
            ObjectSet("ML TL4 Candid W1monthly-"+zXmonthly,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML TL4 Candid W1monthly-"+zXmonthly,OBJPROP_COLOR,Brown);
            ObjectSet("ML TL4 Candid W1monthly-"+zXmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
           }
         if(iLow(NULL,PERIOD_MN1,zXmonthly)>minTL2monthly && candlesizeTL4monthly>3 && iLow(NULL,PERIOD_MN1,zXmonthly)<minTL2monthly+(TLmonthly-LLmonthly) && downshadowzXmonthly>=(BodyzXmonthly/4))
           {
            TL4monthly=iLow(NULL,PERIOD_MN1,zXmonthly);
            if(TL4monthly<minTL4monthly)minTL4monthly=TL4monthly;
            ObjectCreate("ML TL4 Candid W2monthly-"+zXmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_MN1,zXmonthly),iHigh(NULL,PERIOD_MN1,zXmonthly));
            ObjectSet("ML TL4 Candid W2monthly-"+zXmonthly,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML TL4 Candid W2monthly-"+zXmonthly,OBJPROP_COLOR,Brown);
            ObjectSet("ML TL4 Candid W2monthly-"+zXmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
           }
         if(iLow(NULL,PERIOD_MN1,zXmonthly)>minTL2monthly && iLow(NULL,PERIOD_MN1,zXmonthly)<minTL2monthly+(TLmonthly-LLmonthly) && iClose(NULL,PERIOD_MN1,zXmonthly)<iOpen(NULL,PERIOD_MN1,zXmonthly) && iHigh(NULL,PERIOD_MN1,(zXmonthly-1))>((0.45*BodyzXmonthly*Point)+iClose(NULL,PERIOD_MN1,zXmonthly)) && candlesizeTL4monthly>3)
           {
            TL4monthly=iLow(NULL,PERIOD_MN1,zXmonthly);
            if(TL4monthly<minTL4monthly)minTL4monthly=TL4monthly;
            ObjectCreate("ML TL4 Candid W3monthly-"+zXmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_MN1,zXmonthly),iHigh(NULL,PERIOD_MN1,zXmonthly));
            ObjectSet("ML TL4 Candid W3monthly-"+zXmonthly,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML TL4 Candid W3monthly-"+zXmonthly,OBJPROP_COLOR,Brown);
            ObjectSet("ML TL4 Candid W3monthly-"+zXmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
           }

         zXmonthly++;
        }

      if(minTL4monthly==minTL2monthly+(TLmonthly-LLmonthly) || minTL4monthly>=minTL2monthly+((minTL2monthly-TLmonthly)/variable2))
        {
         int shoroLXXmonthly=iBarShift(NULL,PERIOD_W1,iTime(NULL,PERIOD_MN1,q));
         ObjectCreate("ML shoroLD1XXmonthly-"+shoroLXXmonthly,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,shoroLXXmonthly-1),iLow(NULL,PERIOD_W1,shoroLXXmonthly-1));
         ObjectSet("ML shoroLD1XXmonthly-"+shoroLXXmonthly,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroLD1XXmonthly-"+shoroLXXmonthly,OBJPROP_COLOR,Red);
         ObjectSet("ML shoroLD1XXmonthly-"+shoroLXXmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);

         int zXXmonthly=q;
         int nzXXmonthly=q;
         int countXXmonthly=0;
         double BodyzXXmonthly;
         double upshadowzXXmonthly;
         double downshadowzXXmonthly;

         while(zXXmonthly<(iBars(NULL,PERIOD_W1)-1) && countXXmonthly<=MaxTPSLCalcmonthly && countXXmonthly<=iBars(NULL,PERIOD_W1)-2-zXXmonthly)
           {
            if(iClose(NULL,PERIOD_W1,zXXmonthly)>iOpen(NULL,PERIOD_W1,zXXmonthly))
              {
               upshadowzXXmonthly=MathAbs((iHigh(NULL,PERIOD_W1,zXXmonthly)-iClose(NULL,PERIOD_W1,zXXmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zXXmonthly)<iOpen(NULL,PERIOD_W1,zXXmonthly))
              {
               upshadowzXXmonthly=MathAbs((iHigh(NULL,PERIOD_W1,zXXmonthly)-iOpen(NULL,PERIOD_W1,zXXmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zXXmonthly)>iOpen(NULL,PERIOD_W1,zXXmonthly))
              {
               downshadowzXXmonthly=MathAbs((iLow(NULL,PERIOD_W1,zXXmonthly)-iOpen(NULL,PERIOD_W1,zXXmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zXXmonthly)<iOpen(NULL,PERIOD_W1,zXXmonthly))
              {
               downshadowzXXmonthly=MathAbs((iLow(NULL,PERIOD_W1,zXXmonthly)-iClose(NULL,PERIOD_W1,zXXmonthly)+(1*Point))/Point);
              }

            BodyzXXmonthly=MathAbs(iClose(NULL,PERIOD_W1,zXXmonthly)-iOpen(NULL,PERIOD_W1,zXXmonthly))/Point;

            int nTL4Xmonthly=zXXmonthly;
            int MaxNTL4Xmonthly=zXXmonthly;
            double MaxBodyTL4Xmonthly=zXXmonthly;
            while(nTL4Xmonthly<(nOfCandleWmonthly+zXXmonthly))
              {
               double BodyTL4Xmonthly=((iOpen(NULL,PERIOD_W1,nTL4Xmonthly)-iClose(NULL,PERIOD_W1,nTL4Xmonthly))/Point);
               double dyTL4Xmonthly=MathAbs(BodyTL4Xmonthly);
               if(dyTL4Xmonthly>MaxBodyTL4Xmonthly)
                 {
                  MaxBodyTL4Xmonthly=dyTL4Xmonthly;
                  MaxNTL4Xmonthly=nTL4Xmonthly;
                 }
               nTL4Xmonthly++;
              }

            int n2TL4Xmonthly=zXXmonthly;
            int MaxN2TL4Xmonthly=zXXmonthly;
            double MaxBody2TL4Xmonthly=zXXmonthly;
            while(n2TL4Xmonthly<(nOfCandleWmonthly+zXXmonthly))
              {
               double Body2TL4Xmonthly=((iOpen(NULL,PERIOD_W1,n2TL4Xmonthly)-iClose(NULL,PERIOD_W1,n2TL4Xmonthly))/Point);
               double dy2TL4Xmonthly=MathAbs(Body2TL4Xmonthly);
               if(dy2TL4Xmonthly<MaxBodyTL4Xmonthly && dy2TL4Xmonthly>MaxBody2TL4Xmonthly)
                 {
                  MaxBody2TL4Xmonthly=dy2TL4Xmonthly;
                  MaxN2TL4Xmonthly=n2TL4Xmonthly;
                 }
               n2TL4Xmonthly++;
              }

            double darsadTL4Xmonthly=(BodyzXXmonthly/((MaxBodyTL4Xmonthly+MaxBody2TL4Xmonthly)/2))*100;

            double candlesizeTL4Xmonthly;
            if(darsadTL4Xmonthly>=59)
               candlesizeTL4Xmonthly=4;
            if(darsadTL4Xmonthly<59 && darsadTL4Xmonthly>=39)
               candlesizeTL4Xmonthly=3;
            if(darsadTL4Xmonthly<39 && darsadTL4Xmonthly>5)
               candlesizeTL4Xmonthly=2;
            if(darsadTL4Xmonthly<=5)
               candlesizeTL4Xmonthly=1;

            if(iLow(NULL,PERIOD_W1,zXXmonthly)>minTL2monthly+((TLmonthly-LLmonthly)/variable) && iLow(NULL,PERIOD_W1,zXXmonthly)<minTL2monthly+(TLmonthly-LLmonthly) && candlesizeTL4Xmonthly<3 && downshadowzXXmonthly>=BodyzXXmonthly)
              {
               TL4monthly=iLow(NULL,PERIOD_W1,zXXmonthly);
               if(TL4monthly<minTL4monthly)minTL4monthly=TL4monthly;
               ObjectCreate("ML TL4X Candid W1monthly-"+zXXmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zXXmonthly),iHigh(NULL,PERIOD_W1,zXXmonthly));
               ObjectSet("ML TL4X Candid W1monthly-"+zXXmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4X Candid W1monthly-"+zXXmonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4X Candid W1monthly-"+zXXmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }
            if(iLow(NULL,PERIOD_W1,zXXmonthly)>minTL2monthly+((TLmonthly-LLmonthly)/variable) && candlesizeTL4Xmonthly>3 && iLow(NULL,PERIOD_W1,zXXmonthly)<minTL2monthly+(TLmonthly-LLmonthly) && downshadowzXXmonthly>=(BodyzXXmonthly/4))
              {
               TL4monthly=iLow(NULL,PERIOD_W1,zXXmonthly);
               if(TL4monthly<minTL4monthly)minTL4monthly=TL4monthly;
               ObjectCreate("ML TL4X Candid W2monthly-"+zXXmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zXXmonthly),iHigh(NULL,PERIOD_W1,zXXmonthly));
               ObjectSet("ML TL4X Candid W2monthly-"+zXXmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4X Candid W2monthly-"+zXXmonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4X Candid W2monthly-"+zXXmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }
            if(iLow(NULL,PERIOD_W1,zXXmonthly)>minTL2monthly+((TLmonthly-LLmonthly)/variable) && iLow(NULL,PERIOD_W1,zXXmonthly)<minTL2monthly+(TL-LLmonthly) && iClose(NULL,PERIOD_W1,zXXmonthly)<iOpen(NULL,PERIOD_W1,zXXmonthly) && iHigh(NULL,PERIOD_W1,(zXXmonthly-1))>((0.45*BodyzXXmonthly*Point)+iClose(NULL,PERIOD_W1,zXXmonthly)) && candlesizeTL4Xmonthly>3)
              {
               TL4monthly=iLow(NULL,PERIOD_W1,zXXmonthly);
               if(TL4monthly<minTL4monthly)minTL4monthly=TL4monthly;
               ObjectCreate("ML TL4X Candid W3monthly-"+zXXmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zXXmonthly),iHigh(NULL,PERIOD_W1,zXXmonthly));
               ObjectSet("ML TL4X Candid W3monthly-"+zXXmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4X Candid W3monthly-"+zXXmonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4X Candid W3monthly-"+zXXmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }

            zXXmonthly++;
           }

        }

      if(minTL4monthly==minTL2monthly+(TLmonthly-LLmonthly) || minTL4monthly>=minTL2monthly+((minTL2monthly-TLmonthly)/variable2))
        {
         int shoroLXXXmonthly=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q));
         ObjectCreate("ML shoroLD1XXXmonthly-"+shoroLXXXmonthly,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,shoroLXXXmonthly-1),iLow(NULL,PERIOD_D1,shoroLXXXmonthly-1));
         ObjectSet("ML shoroLD1XXXmonthly-"+shoroLXXXmonthly,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroLD1XXXmonthly-"+shoroLXXXmonthly,OBJPROP_COLOR,Red);
         ObjectSet("ML shoroLD1XXXmonthly-"+shoroLXXXmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);

         int zXXXmonthly=q;
         int nzXXXmonthly=q;
         int countXXXmonthly=0;
         double BodyzXXXmonthly;
         double upshadowzXXXmonthly;
         double downshadowzXXXmonthly;

         while(zXXXmonthly<(iBars(NULL,PERIOD_D1)-1) && countXXXmonthly<=MaxTPSLCalcmonthly && countXXXmonthly<=iBars(NULL,PERIOD_D1)-2-zXXXmonthly)
           {
            if(iClose(NULL,PERIOD_D1,zXXXmonthly)>iOpen(NULL,PERIOD_D1,zXXXmonthly))
              {
               upshadowzXXXmonthly=MathAbs((iHigh(NULL,PERIOD_D1,zXXXmonthly)-iClose(NULL,PERIOD_D1,zXXXmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_D1,zXXXmonthly)<iOpen(NULL,PERIOD_D1,zXXXmonthly))
              {
               upshadowzXXXmonthly=MathAbs((iHigh(NULL,PERIOD_D1,zXXXmonthly)-iOpen(NULL,PERIOD_D1,zXXXmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_D1,zXXXmonthly)>iOpen(NULL,PERIOD_D1,zXXXmonthly))
              {
               downshadowzXXXmonthly=MathAbs((iLow(NULL,PERIOD_D1,zXXXmonthly)-iOpen(NULL,PERIOD_D1,zXXXmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_D1,zXXXmonthly)<iOpen(NULL,PERIOD_D1,zXXXmonthly))
              {
               downshadowzXXXmonthly=MathAbs((iLow(NULL,PERIOD_D1,zXXXmonthly)-iClose(NULL,PERIOD_D1,zXXXmonthly)+(1*Point))/Point);
              }

            BodyzXXXmonthly=MathAbs(iClose(NULL,PERIOD_D1,zXXXmonthly)-iOpen(NULL,PERIOD_D1,zXXXmonthly))/Point;

            int nTL4XXmonthly=zXXXmonthly;
            int MaxNTL4XXmonthly=zXXXmonthly;
            double MaxBodyTL4XXmonthly=zXXXmonthly;
            while(nTL4XXmonthly<(nOfCandleWmonthly+zXXXmonthly))
              {
               double BodyTL4XXmonthly=((iOpen(NULL,PERIOD_D1,nTL4XXmonthly)-iClose(NULL,PERIOD_D1,nTL4XXmonthly))/Point);
               double dyTL4XXmonthly=MathAbs(BodyTL4XXmonthly);
               if(dyTL4XXmonthly>MaxBodyTL4XXmonthly)
                 {
                  MaxBodyTL4XXmonthly=dyTL4XXmonthly;
                  MaxNTL4XXmonthly=nTL4XXmonthly;
                 }
               nTL4XXmonthly++;
              }

            int n2TL4XXmonthly=zXXXmonthly;
            int MaxN2TL4XXmonthly=zXXXmonthly;
            double MaxBody2TL4XXmonthly=zXXXmonthly;
            while(n2TL4XXmonthly<(nOfCandleWmonthly+zXXXmonthly))
              {
               double Body2TL4XXmonthly=((iOpen(NULL,PERIOD_D1,n2TL4XXmonthly)-iClose(NULL,PERIOD_D1,n2TL4XXmonthly))/Point);
               double dy2TL4XXmonthly=MathAbs(Body2TL4XXmonthly);
               if(dy2TL4XXmonthly<MaxBodyTL4XXmonthly && dy2TL4XXmonthly>MaxBody2TL4XXmonthly)
                 {
                  MaxBody2TL4XXmonthly=dy2TL4XXmonthly;
                  MaxN2TL4XXmonthly=n2TL4XXmonthly;
                 }
               n2TL4XXmonthly++;
              }

            double darsadTL4XXmonthly=(BodyzXXXmonthly/((MaxBodyTL4XXmonthly+MaxBody2TL4XXmonthly)/2))*100;

            double candlesizeTL4XXmonthly;
            if(darsadTL4XXmonthly>=59)
               candlesizeTL4XXmonthly=4;
            if(darsadTL4XXmonthly<59 && darsadTL4XXmonthly>=39)
               candlesizeTL4XXmonthly=3;
            if(darsadTL4XXmonthly<39 && darsadTL4XXmonthly>5)
               candlesizeTL4XXmonthly=2;
            if(darsadTL4XXmonthly<=5)
               candlesizeTL4XXmonthly=1;

            if(iLow(NULL,PERIOD_D1,zXXXmonthly)>minTL2monthly+((TLmonthly-LLmonthly)/variable) && iLow(NULL,PERIOD_D1,zXXXmonthly)<minTL2monthly+(TLmonthly-LLmonthly) && candlesizeTL4XXmonthly<3 && downshadowzXXXmonthly>=BodyzXXXmonthly)
              {
               TL4monthly=iLow(NULL,PERIOD_D1,zXXXmonthly);
               if(TL4monthly<minTL4monthly)minTL4monthly=TL4monthly;
               ObjectCreate("ML TL4XX Candid W1monthly-"+zXXXmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zXXXmonthly),iHigh(NULL,PERIOD_D1,zXXXmonthly));
               ObjectSet("ML TL4XX Candid W1monthly-"+zXXXmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4XX Candid W1monthly-"+zXXXmonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4XX Candid W1monthly-"+zXXXmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
              }
            if(iLow(NULL,PERIOD_D1,zXXXmonthly)>minTL2monthly+((TLmonthly-LLmonthly)/variable) && candlesizeTL4XXmonthly>3 && iLow(NULL,PERIOD_D1,zXXXmonthly)<minTL2monthly+(TLmonthly-LLmonthly) && downshadowzXXXmonthly>=(BodyzXXXmonthly/4))
              {
               TL4monthly=iLow(NULL,PERIOD_D1,zXXXmonthly);
               if(TL4monthly<minTL4monthly)minTL4monthly=TL4monthly;
               ObjectCreate("ML TL4XX Candid W2monthly-"+zXXXmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zXXXmonthly),iHigh(NULL,PERIOD_D1,zXXXmonthly));
               ObjectSet("ML TL4XX Candid W2monthly-"+zXXXmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4XX Candid W2monthly-"+zXXXmonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4XX Candid W2monthly-"+zXXXmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
              }
            if(iLow(NULL,PERIOD_D1,zXXXmonthly)>minTL2monthly+((TLmonthly-LLmonthly)/variable) && iLow(NULL,PERIOD_D1,zXXXmonthly)<minTL2monthly+(TLmonthly-LLmonthly) && iClose(NULL,PERIOD_D1,zXXXmonthly)<iOpen(NULL,PERIOD_D1,zXXXmonthly) && iHigh(NULL,PERIOD_D1,(zXXXmonthly-1))>((0.45*BodyzXXXmonthly*Point)+iClose(NULL,PERIOD_D1,zXXXmonthly)) && candlesizeTL4XXmonthly>3)
              {
               TL4monthly=iLow(NULL,PERIOD_D1,zXXXmonthly);
               if(TL4monthly<minTL4monthly)minTL4monthly=TL4monthly;
               ObjectCreate("ML TL4XX Candid W3monthly-"+zXXXmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zXXXmonthly),iHigh(NULL,PERIOD_D1,zXXXmonthly));
               ObjectSet("ML TL4XX Candid W3monthly-"+zXXXmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4XX Candid W3monthly-"+zXXXmonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4XX Candid W3monthly-"+zXXXmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
              }

            zXXXmonthly++;
           }

        }

      int zX2monthly=q;
      int nzX2monthly=q;
      int countX2monthly=0;
      double BodyzX2monthly;
      double upshadowzX2monthly;
      double downshadowzX2monthly;
      minTL3monthly=minTL2monthly;

      while(zX2monthly<(iBars(NULL,PERIOD_MN1)-1) && countX2monthly<=MaxTPSLCalcmonthly && countX2monthly<=iBars(NULL,PERIOD_MN1)-2-zX2monthly)
        {

         if(iClose(NULL,PERIOD_MN1,zX2monthly)>iOpen(NULL,PERIOD_MN1,zX2monthly))
           {
            upshadowzX2monthly=MathAbs((iHigh(NULL,PERIOD_MN1,zX2monthly)-iClose(NULL,PERIOD_MN1,zX2monthly)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_MN1,zX2monthly)<iOpen(NULL,PERIOD_MN1,zX2monthly))
           {
            upshadowzX2monthly=MathAbs((iHigh(NULL,PERIOD_MN1,zX2monthly)-iOpen(NULL,PERIOD_MN1,zX2monthly)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_MN1,zX2monthly)>iOpen(NULL,PERIOD_MN1,zX2monthly))
           {
            downshadowzX2monthly=MathAbs((iLow(NULL,PERIOD_MN1,zX2monthly)-iOpen(NULL,PERIOD_MN1,zX2monthly)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_MN1,zX2monthly)<iOpen(NULL,PERIOD_MN1,zX2monthly))
           {
            downshadowzX2monthly=MathAbs((iLow(NULL,PERIOD_MN1,zX2monthly)-iClose(NULL,PERIOD_MN1,zX2monthly)+(1*Point))/Point);
           }

         BodyzX2monthly=MathAbs(iClose(NULL,PERIOD_MN1,zX2monthly)-iOpen(NULL,PERIOD_MN1,zX2monthly))/Point;

         int nTL3monthly=zX2monthly;
         int MaxNTL3monthly=zX2monthly;
         double MaxBodyTL3monthly=zX2monthly;
         while(nTL3monthly<(nOfCandleWmonthly+zX2monthly))
           {
            double BodyTL3monthly=((iOpen(NULL,PERIOD_MN1,nTL3monthly)-iClose(NULL,PERIOD_MN1,nTL3monthly))/Point);
            double dyTL3monthly=MathAbs(BodyTL3monthly);
            if(dyTL3monthly>MaxBodyTL3monthly)
              {
               MaxBodyTL3monthly=dyTL3monthly;
               MaxNTL3monthly=nTL3monthly;
              }
            nTL3monthly++;
           }

         int n2TL3monthly=zX2monthly;
         int MaxN2TL3monthly=zX2monthly;
         double MaxBody2TL3monthly=zX2monthly;
         while(n2TL3monthly<(nOfCandleWmonthly+zX2monthly))
           {
            double Body2TL3monthly=((iOpen(NULL,PERIOD_MN1,n2TL3monthly)-iClose(NULL,PERIOD_MN1,n2TL3monthly))/Point);
            double dy2TL3monthly=MathAbs(Body2TL3monthly);
            if(dy2TL3monthly<MaxBodyTL3monthly && dy2TL3monthly>MaxBody2TL3monthly)
              {
               MaxBody2TL3monthly=dy2TL3monthly;
               MaxN2TL3monthly=n2TL3monthly;
              }
            n2TL3monthly++;
           }

         double darsadTL3monthly=(BodyzX2monthly/((MaxBodyTL3monthly+MaxBody2TL3monthly)/2))*100;

         double candlesizeTL3monthly;
         if(darsadTL3monthly>=59)
            candlesizeTL3monthly=4;
         if(darsadTL3monthly<59 && darsadTL3monthly>=39)
            candlesizeTL3monthly=3;
         if(darsadTL3monthly<39 && darsadTL3monthly>5)
            candlesizeTL3monthly=2;
         if(darsadTL3monthly<=5)
            candlesizeTL3monthly=1;

         minTL3monthly=minTL2monthly;

         if(iLow(NULL,PERIOD_MN1,zX2monthly)>TLmonthly+((TLmonthly-LLmonthly)/variable) && iLow(NULL,PERIOD_MN1,zX2monthly)<minTL2monthly && candlesizeTL3monthly<3 && downshadowzX2monthly>=BodyzX2monthly)
           {
            TL3monthly=iLow(NULL,PERIOD_MN1,zX2monthly);
            if(TL3monthly<minTL3monthly)minTL3monthly=TL3monthly;
            ObjectCreate("ML TL3 Candid W1monthly-"+zX2monthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_MN1,zX2monthly),iHigh(NULL,PERIOD_MN1,zX2monthly));
            ObjectSet("ML TL3 Candid W1monthly-"+zX2monthly,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML TL3 Candid W1monthly-"+zX2monthly,OBJPROP_COLOR,Yellow);
            ObjectSet("ML TL3 Candid W1monthly-"+zX2monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
           }
         if(iLow(NULL,PERIOD_MN1,zX2monthly)>TLmonthly+((TLmonthly-LLmonthly)/variable) && candlesizeTL3monthly>3 && iLow(NULL,PERIOD_MN1,zX2monthly)<minTL2monthly && downshadowzX2monthly>=(BodyzX2monthly/4))
           {
            TL3monthly=iLow(NULL,PERIOD_MN1,zX2);
            if(TL3monthly<minTL3monthly)minTL3monthly=TL3monthly;
            ObjectCreate("ML TL3 Candid W2monthly-"+zX2monthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_MN1,zX2monthly),iHigh(NULL,PERIOD_MN1,zX2monthly));
            ObjectSet("ML TL3 Candid W2monthly-"+zX2monthly,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML TL3 Candid W2monthly-"+zX2monthly,OBJPROP_COLOR,Yellow);
            ObjectSet("ML TL3 Candid W2monthly-"+zX2monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
           }
         if(iLow(NULL,PERIOD_MN1,zX2monthly)>TLmonthly+((TLmonthly-LLmonthly)/variable) && iLow(NULL,PERIOD_MN1,zX2monthly)<minTL2 && iClose(NULL,PERIOD_MN1,zX2monthly)<iOpen(NULL,PERIOD_MN1,zX2monthly) && iHigh(NULL,PERIOD_MN1,(zX2monthly-1))>((0.45*BodyzX2monthly*Point)+iClose(NULL,PERIOD_MN1,zX2monthly)) && candlesizeTL3monthly>3)
           {
            TL3monthly=iLow(NULL,PERIOD_MN1,zX2monthly);
            if(TL3monthly<minTL3monthly)minTL3monthly=TL3monthly;
            ObjectCreate("ML TL4 Candid W3monthly-"+zX2monthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_MN1,zX2monthly),iHigh(NULL,PERIOD_MN1,zX2monthly));
            ObjectSet("ML TL4 Candid W3monthly-"+zX2monthly,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML TL4 Candid W3monthly-"+zX2monthly,OBJPROP_COLOR,Brown);
            ObjectSet("ML TL4 Candid W3monthly-"+zX2monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
           }

         zX2monthly++;

        }

      if(minTL3monthly==minTL2monthly || minTL3monthly>=TLmonthly+((minTL2monthly-TLmonthly)/variable2))
        {

         int shoroLXXLmonthly=iBarShift(NULL,PERIOD_W1,iTime(NULL,PERIOD_MN1,q));
         ObjectCreate("ML shoroLD1XXmonthly-"+shoroLXXLmonthly,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,shoroLXXLmonthly-1),iLow(NULL,PERIOD_W1,shoroLXXLmonthly-1));
         ObjectSet("ML shoroLD1XXmonthly-"+shoroLXXLmonthly,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroLD1XXmonthly-"+shoroLXXLmonthly,OBJPROP_COLOR,Red);
         ObjectSet("ML shoroLD1XXmonthly-"+shoroLXXLmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);

         int zX2Ymonthly=q;
         int nzX2Ymonthly=q;
         int countX2Ymonthly=0;
         double BodyzX2Ymonthly;
         double upshadowzX2Ymonthly;
         double downshadowzX2Ymonthly;
         minTL3monthly=minTL2monthly;

         while(zX2Ymonthly<(iBars(NULL,PERIOD_W1)-1) && countX2Ymonthly<=MaxTPSLCalcmonthly && countX2Ymonthly<=iBars(NULL,PERIOD_W1)-2-zX2Ymonthly)
           {
            if(iClose(NULL,PERIOD_W1,zX2Ymonthly)>iOpen(NULL,PERIOD_W1,zX2Ymonthly))
              {
               upshadowzX2Ymonthly=MathAbs((iHigh(NULL,PERIOD_W1,zX2Ymonthly)-iClose(NULL,PERIOD_W1,zX2Ymonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zX2Ymonthly)<iOpen(NULL,PERIOD_W1,zX2Ymonthly))
              {
               upshadowzX2Ymonthly=MathAbs((iHigh(NULL,PERIOD_W1,zX2Ymonthly)-iOpen(NULL,PERIOD_W1,zX2Ymonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zX2Ymonthly)>iOpen(NULL,PERIOD_W1,zX2Ymonthly))
              {
               downshadowzX2Ymonthly=MathAbs((iLow(NULL,PERIOD_W1,zX2Ymonthly)-iOpen(NULL,PERIOD_W1,zX2Ymonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zX2Ymonthly)<iOpen(NULL,PERIOD_W1,zX2Ymonthly))
              {
               downshadowzX2Ymonthly=MathAbs((iLow(NULL,PERIOD_W1,zX2Ymonthly)-iClose(NULL,PERIOD_W1,zX2Ymonthly)+(1*Point))/Point);
              }

            BodyzX2Ymonthly=MathAbs(iClose(NULL,PERIOD_W1,zX2Ymonthly)-iOpen(NULL,PERIOD_W1,zX2Ymonthly))/Point;

            int nTL3Ymonthly=zX2Ymonthly;
            int MaxNTL3Ymonthly=zX2Ymonthly;
            double MaxBodyTL3Ymonthly=zX2Ymonthly;
            while(nTL3Ymonthly<(nOfCandleWmonthly+zX2Ymonthly))
              {
               double BodyTL3Ymonthly=((iOpen(NULL,PERIOD_W1,nTL3Ymonthly)-iClose(NULL,PERIOD_W1,nTL3Ymonthly))/Point);
               double dyTL3Ymonthly=MathAbs(BodyTL3Ymonthly);
               if(dyTL3Ymonthly>MaxBodyTL3Ymonthly)
                 {
                  MaxBodyTL3Ymonthly=dyTL3Ymonthly;
                  MaxNTL3Ymonthly=nTL3Ymonthly;
                 }
               nTL3Ymonthly++;
              }

            int n2TL3Ymonthly=zX2Ymonthly;
            int MaxN2TL3Ymonthly=zX2Ymonthly;
            double MaxBody2TL3Ymonthly=zX2Ymonthly;
            while(n2TL3Ymonthly<(nOfCandleWmonthly+zX2Ymonthly))
              {
               double Body2TL3Ymonthly=((iOpen(NULL,PERIOD_W1,n2TL3Ymonthly)-iClose(NULL,PERIOD_W1,n2TL3Ymonthly))/Point);
               double dy2TL3Ymonthly=MathAbs(Body2TL3Ymonthly);
               if(dy2TL3Ymonthly<MaxBodyTL3Ymonthly && dy2TL3Ymonthly>MaxBody2TL3Ymonthly)
                 {
                  MaxBody2TL3Ymonthly=dy2TL3Ymonthly;
                  MaxN2TL3Ymonthly=n2TL3Ymonthly;
                 }
               n2TL3Ymonthly++;
              }

            double darsadTL3Ymonthly=(BodyzX2Ymonthly/((MaxBodyTL3Ymonthly+MaxBody2TL3Ymonthly)/2))*100;

            double candlesizeTL3Ymonthly;
            if(darsadTL3Ymonthly>=59)
               candlesizeTL3Ymonthly=4;
            if(darsadTL3Ymonthly<59 && darsadTL3Ymonthly>=39)
               candlesizeTL3Ymonthly=3;
            if(darsadTL3Ymonthly<39 && darsadTL3Ymonthly>5)
               candlesizeTL3Ymonthly=2;
            if(darsadTL3Ymonthly<=5)
               candlesizeTL3Ymonthly=1;

            if(iLow(NULL,PERIOD_W1,zX2Ymonthly)>TLmonthly+((TLmonthly-LLmonthly)/variable) && iLow(NULL,PERIOD_W1,zX2Ymonthly)<minTL2monthly && candlesizeTL3Ymonthly<3 && downshadowzX2Ymonthly>=BodyzX2Ymonthly)
              {
               TL3monthly=iLow(NULL,PERIOD_W1,zX2Ymonthly);
               if(TL3monthly<minTL3monthly)minTL3monthly=TL3monthly;
               ObjectCreate("ML TL3Y Candid W1monthly-"+zX2Ymonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zX2Ymonthly),iHigh(NULL,PERIOD_W1,zX2Ymonthly));
               ObjectSet("ML TL3Y Candid W1monthly-"+zX2Ymonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL3Y Candid W1monthly-"+zX2Ymonthly,OBJPROP_COLOR,Yellow);
               ObjectSet("ML TL3Y Candid W1monthly-"+zX2Ymonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }
            if(iLow(NULL,PERIOD_W1,zX2Y)>TLmonthly+((TLmonthly-LLmonthly)/variable) && candlesizeTL3Y>3 && iLow(NULL,PERIOD_W1,zX2Ymonthly)<minTL2monthly && downshadowzX2Ymonthly>=(BodyzX2Ymonthly/4))
              {
               TL3monthly=iLow(NULL,PERIOD_W1,zX2Ymonthly);
               if(TL3monthly<minTL3monthly)minTL3monthly=TL3monthly;
               ObjectCreate("ML TL3Y Candid W2monthly-"+zX2Ymonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zX2Ymonthly),iHigh(NULL,PERIOD_W1,zX2Ymonthly));
               ObjectSet("ML TL3Y Candid W2monthly-"+zX2Ymonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL3Y Candid W2monthly-"+zX2Ymonthly,OBJPROP_COLOR,Yellow);
               ObjectSet("ML TL3Y Candid W2monthly-"+zX2Ymonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }
            if(iLow(NULL,PERIOD_W1,zX2Ymonthly)>TLmonthly+((TLmonthly-LLmonthly)/variable) && iLow(NULL,PERIOD_W1,zX2Ymonthly)<minTL2monthly && iClose(NULL,PERIOD_W1,zX2Ymonthly)<iOpen(NULL,PERIOD_W1,zX2Ymonthly) && iHigh(NULL,PERIOD_W1,(zX2Ymonthly-1))>iClose(NULL,PERIOD_W1,zX2Ymonthly)+(0.45*BodyzX2Ymonthly*Point) && candlesizeTL3Ymonthly>3)
              {
               TL4monthly=iLow(NULL,PERIOD_W1,zX2Ymonthly);
               if(TL3monthly<minTL3monthly)minTL3monthly=TL3monthly;
               ObjectCreate("ML TL4Y Candid W3monthly-"+zX2Ymonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zX2Ymonthly),iHigh(NULL,PERIOD_W1,zX2Ymonthly));
               ObjectSet("ML TL4Y Candid W3monthly-"+zX2Ymonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4Y Candid W3monthly-"+zX2Ymonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4Y Candid W3monthly-"+zX2Ymonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }

            zX2Ymonthly++;
           }

        }

      if(minTL3monthly==minTL2monthly || minTL3monthly>=TLmonthly+((minTL2monthly-TLmonthly)/variable2))
        {
         int shoroLXXLLmonthly=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q));
         ObjectCreate("ML shoroLD1XXLmonthly-"+shoroLXXLLmonthly,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,shoroLXXLLmonthly-1),iLow(NULL,PERIOD_D1,shoroLXXLLmonthly-1));
         ObjectSet("ML shoroLD1XXLmonthly-"+shoroLXXLLmonthly,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroLD1XXLmonthly-"+shoroLXXLLmonthly,OBJPROP_COLOR,Red);
         ObjectSet("ML shoroLD1XXLmonthly-"+shoroLXXLLmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);

         int zX2YYmonthly=q;
         int nzX2YYmonthly=q;
         int countX2YYmonthly=0;
         double BodyzX2YYmonthly;
         double upshadowzX2YYmonthly;
         double downshadowzX2YYmonthly;
         minTL3monthly=minTL2monthly;

         while(zX2YYmonthly<(iBars(NULL,PERIOD_D1)-1) && countX2YYmonthly<=MaxTPSLCalcmonthly && countX2YYmonthly<=iBars(NULL,PERIOD_D1)-2-zX2YYmonthly)
           {
            if(iClose(NULL,PERIOD_D1,zX2YYmonthly)>iOpen(NULL,PERIOD_D1,zX2YYmonthly))
              {
               upshadowzX2YYmonthly=MathAbs((iHigh(NULL,PERIOD_D1,zX2YYmonthly)-iClose(NULL,PERIOD_D1,zX2YYmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_D1,zX2YYmonthly)<iOpen(NULL,PERIOD_D1,zX2YYmonthly))
              {
               upshadowzX2YYmonthly=MathAbs((iHigh(NULL,PERIOD_D1,zX2YYmonthly)-iOpen(NULL,PERIOD_D1,zX2YYmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_D1,zX2YYmonthly)>iOpen(NULL,PERIOD_D1,zX2YYmonthly))
              {
               downshadowzX2YYmonthly=MathAbs((iLow(NULL,PERIOD_D1,zX2YYmonthly)-iOpen(NULL,PERIOD_D1,zX2YYmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_D1,zX2YYmonthly)<iOpen(NULL,PERIOD_D1,zX2YYmonthly))
              {
               downshadowzX2YYmonthly=MathAbs((iLow(NULL,PERIOD_D1,zX2YYmonthly)-iClose(NULL,PERIOD_D1,zX2YYmonthly)+(1*Point))/Point);
              }

            BodyzX2YYmonthly=MathAbs(iClose(NULL,PERIOD_D1,zX2YYmonthly)-iOpen(NULL,PERIOD_D1,zX2YYmonthly))/Point;

            int nTL3YYmonthly=zX2YYmonthly;
            int MaxNTL3YYmonthly=zX2YYmonthly;
            double MaxBodyTL3YYmonthly=zX2YYmonthly;
            while(nTL3YYmonthly<(nOfCandleWmonthly+zX2YYmonthly))
              {
               double BodyTL3YYmonthly=((iOpen(NULL,PERIOD_D1,nTL3YYmonthly)-iClose(NULL,PERIOD_D1,nTL3YYmonthly))/Point);
               double dyTL3YYmonthly=MathAbs(BodyTL3YYmonthly);
               if(dyTL3YYmonthly>MaxBodyTL3YYmonthly)
                 {
                  MaxBodyTL3YYmonthly=dyTL3YYmonthly;
                  MaxNTL3YYmonthly=nTL3YYmonthly;
                 }
               nTL3YYmonthly++;
              }

            int n2TL3YYmonthly=zX2YYmonthly;
            int MaxN2TL3YYmonthly=zX2YYmonthly;
            double MaxBody2TL3YYmonthly=zX2YYmonthly;
            while(n2TL3YYmonthly<(nOfCandleWmonthly+zX2YYmonthly))
              {
               double Body2TL3YYmonthly=((iOpen(NULL,PERIOD_D1,n2TL3YYmonthly)-iClose(NULL,PERIOD_D1,n2TL3YYmonthly))/Point);
               double dy2TL3YYmonthly=MathAbs(Body2TL3YYmonthly);
               if(dy2TL3YYmonthly<MaxBodyTL3YYmonthly && dy2TL3YYmonthly>MaxBody2TL3YYmonthly)
                 {
                  MaxBody2TL3YYmonthly=dy2TL3YYmonthly;
                  MaxN2TL3YYmonthly=n2TL3YYmonthly;
                 }
               n2TL3YYmonthly++;
              }

            double darsadTL3YYmonthly=(BodyzX2YYmonthly/((MaxBodyTL3YYmonthly+MaxBody2TL3YYmonthly)/2))*100;

            double candlesizeTL3YYmonthly;
            if(darsadTL3YYmonthly>=59)
               candlesizeTL3YYmonthly=4;
            if(darsadTL3YYmonthly<59 && darsadTL3YYmonthly>=39)
               candlesizeTL3YYmonthly=3;
            if(darsadTL3YYmonthly<39 && darsadTL3YYmonthly>5)
               candlesizeTL3YYmonthly=2;
            if(darsadTL3YYmonthly<=5)
               candlesizeTL3YYmonthly=1;

            if(iLow(NULL,PERIOD_D1,zX2YYmonthly)>TLmonthly+((TLmonthly-LLmonthly)/variable) && iLow(NULL,PERIOD_D1,zX2YYmonthly)<minTL2monthly && candlesizeTL3YYmonthly<3 && downshadowzX2YYmonthly>=BodyzX2YYmonthly)
              {
               TL3monthly=iLow(NULL,PERIOD_D1,zX2YYmonthly);
               if(TL3monthly<minTL3monthly)minTL3monthly=TL3monthly;
               ObjectCreate("ML TL3YY Candid W1monthly-"+zX2YYmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zX2YYmonthly),iHigh(NULL,PERIOD_D1,zX2YYmonthly));
               ObjectSet("ML TL3YY Candid W1monthly-"+zX2YYmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL3YY Candid W1monthly-"+zX2YYmonthly,OBJPROP_COLOR,Yellow);
               ObjectSet("ML TL3YY Candid W1monthly-"+zX2YYmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
              }
            if(iLow(NULL,PERIOD_D1,zX2YYmonthly)>TLmonthly+((TLmonthly-LLmonthly)/variable) && candlesizeTL3YYmonthly>3 && iLow(NULL,PERIOD_D1,zX2YYmonthly)<minTL2monthly && downshadowzX2YYmonthly>=(BodyzX2YYmonthly/4))
              {
               TL3monthly=iLow(NULL,PERIOD_D1,zX2YYmonthly);
               if(TL3monthly<minTL3monthly)minTL3monthly=TL3monthly;
               ObjectCreate("ML TL3YY Candid W2monthly-"+zX2YYmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zX2YYmonthly),iHigh(NULL,PERIOD_D1,zX2YYmonthly));
               ObjectSet("ML TL3YY Candid W2monthly-"+zX2YYmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL3YY Candid W2monthly-"+zX2YYmonthly,OBJPROP_COLOR,Yellow);
               ObjectSet("ML TL3YY Candid W2monthly-"+zX2YYmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
              }
            if(iLow(NULL,PERIOD_D1,zX2YYmonthly)>TLmonthly+((TLmonthly-LLmonthly)/variable) && iLow(NULL,PERIOD_D1,zX2YYmonthly)<minTL2monthly && iClose(NULL,PERIOD_D1,zX2YYmonthly)<iOpen(NULL,PERIOD_D1,zX2YYmonthly) && iHigh(NULL,PERIOD_D1,(zX2YYmonthly-1))>iClose(NULL,PERIOD_D1,zX2YYmonthly)+(0.45*BodyzX2YYmonthly*Point) && candlesizeTL3YYmonthly>3)
              {
               TL4monthly=iLow(NULL,PERIOD_D1,zX2YYmonthly);
               if(TL3monthly<minTL3monthly)minTL3monthly=TL3monthly;
               ObjectCreate("ML TL4YY Candid W3monthly-"+zX2YYmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zX2YYmonthly),iHigh(NULL,PERIOD_D1,zX2YYmonthly));
               ObjectSet("ML TL4YY Candid W3monthly-"+zX2YYmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4YY Candid W3monthly-"+zX2YYmonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4YY Candid W3monthly-"+zX2YYmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
              }

            zX2YYmonthly++;
           }

        }

      int zQmonthly=q;
      int nzQmonthly=q;
      int countQmonthly=0;
      double BodyzQmonthly;
      double upshadowzQmonthly;
      double downshadowzQmonthly;
      minLL3monthly=minLL2monthly;

      while(zQmonthly<(iBars(NULL,PERIOD_MN1)-1) && countQmonthly<=MaxTPSLCalcmonthly && countQmonthly<=iBars(NULL,PERIOD_MN1)-2-zQmonthly)
        {
         if(iClose(NULL,PERIOD_MN1,zQmonthly)>iOpen(NULL,PERIOD_MN1,zQmonthly))
           {
            upshadowzQmonthly=MathAbs((iHigh(NULL,PERIOD_MN1,zQmonthly)-iClose(NULL,PERIOD_MN1,zQmonthly)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_MN1,zQmonthly)<iOpen(NULL,PERIOD_MN1,zQmonthly))
           {
            upshadowzQmonthly=MathAbs((iHigh(NULL,PERIOD_MN1,zQmonthly)-iOpen(NULL,PERIOD_MN1,zQmonthly)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_MN1,zQmonthly)>iOpen(NULL,PERIOD_MN1,zQmonthly))
           {
            downshadowzQmonthly=MathAbs((iLow(NULL,PERIOD_MN1,zQmonthly)-iOpen(NULL,PERIOD_MN1,zQmonthly)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_MN1,zQmonthly)<iOpen(NULL,PERIOD_MN1,zQmonthly))
           {
            downshadowzQmonthly=MathAbs((iLow(NULL,PERIOD_MN1,zQmonthly)-iClose(NULL,PERIOD_MN1,zQmonthly)+(1*Point))/Point);
           }

         BodyzQmonthly=MathAbs(iClose(NULL,PERIOD_MN1,zQmonthly)-iOpen(NULL,PERIOD_MN1,zQmonthly))/Point;

         int nLL3monthly=zQmonthly;
         int MaxNLL3monthly=zQmonthly;
         double MaxBodyLL3monthly=zQmonthly;
         while(nLL3monthly<(nOfCandleWmonthly+zQmonthly))
           {
            double BodyLL3monthly=((iOpen(NULL,PERIOD_MN1,nLL3monthly)-iClose(NULL,PERIOD_MN1,nLL3monthly))/Point);
            double dyLL3monthly=MathAbs(BodyLL3monthly);
            if(dyLL3monthly>MaxBodyLL3monthly)
              {
               MaxBodyLL3monthly=dyLL3monthly;
               MaxNLL3monthly=nLL3monthly;
              }
            nLL3monthly++;
           }

         int n2LL3monthly=zQmonthly;
         int MaxN2LL3monthly=zQmonthly;
         double MaxBody2LL3monthly=zQmonthly;
         while(n2LL3monthly<(nOfCandleWmonthly+zQmonthly))
           {
            double Body2LL3monthly=((iOpen(NULL,PERIOD_MN1,n2LL3monthly)-iClose(NULL,PERIOD_MN1,n2LL3monthly))/Point);
            double dy2LL3monthly=MathAbs(Body2LL3monthly);
            if(dy2LL3monthly<MaxBodyLL3monthly && dy2LL3monthly>MaxBody2LL3monthly)
              {
               MaxBody2LL3monthly=dy2LL3monthly;
               MaxN2LL3monthly=n2LL3monthly;
              }
            n2LL3monthly++;
           }

         double darsadLL3monthly=(BodyzQmonthly/((MaxBodyLL3monthly+MaxBody2LL3monthly)/2))*100;

         double candlesizeLL3monthly;
         if(darsadLL3monthly>=59)
            candlesizeLL3monthly=4;
         if(darsadLL3monthly<59 && darsadLL3monthly>=39)
            candlesizeLL3monthly=3;
         if(darsadLL3monthly<39 && darsadLL3monthly>5)
            candlesizeLL3monthly=2;
         if(darsadLL3monthly<=5)
            candlesizeLL3monthly=1;

         if(iHigh(NULL,PERIOD_MN1,zQmonthly)<LLmonthly-((TLmonthly-LLmonthly)/variable) && iHigh(NULL,PERIOD_MN1,zQmonthly)>minLL2monthly && candlesizeLL3monthly<3 && upshadowzQmonthly>=BodyzQmonthly)
           {
            LL3monthly=iHigh(NULL,PERIOD_MN1,zQmonthly);
            if(LL3monthly>minLL3monthly)minLL3monthly=LL3monthly;
            ObjectCreate("ML LL3 Candid W1monthly-"+zQmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_MN1,zQmonthly),iLow(NULL,PERIOD_MN1,zQmonthly));
            ObjectSet("ML LL3 Candid W1monthly-"+zQmonthly,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML LL3 Candid W1monthly-"+zQmonthly,OBJPROP_COLOR,Brown);
            ObjectSet("ML LL3 Candid W1monthly-"+zQmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
           }
         if(iHigh(NULL,PERIOD_MN1,zQmonthly)<LLmonthly-((TLmonthly-LLmonthly)/variable) && candlesizeLL3monthly>3 && iHigh(NULL,PERIOD_MN1,zQmonthly)>minLL2monthly && upshadowzQmonthly>=(BodyzQmonthly/4))
           {
            LL3=iHigh(NULL,PERIOD_MN1,zQmonthly);
            if(LL3monthly>minLL3monthly)minLL3monthly=LL3monthly;
            ObjectCreate("ML LL3 Candid W2monthly-"+zQmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_MN1,zQmonthly),iHigh(NULL,PERIOD_MN1,zQmonthly));
            ObjectSet("ML LL3 Candid W2monthly-"+zQmonthly,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML LL3 Candid W2monthly-"+zQmonthly,OBJPROP_COLOR,Brown);
            ObjectSet("ML LL3 Candid W2monthly-"+zQmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
           }
         if(iHigh(NULL,PERIOD_MN1,zQmonthly)<LLmonthly-((TLmonthly-LLmonthly)/variable) && iHigh(NULL,PERIOD_MN1,zQmonthly)>minLL2monthly && iClose(NULL,PERIOD_MN1,zQmonthly)>iOpen(NULL,PERIOD_MN1,zQmonthly) && iLow(NULL,PERIOD_MN1,(zQmonthly-1))<(iClose(NULL,PERIOD_MN1,zQmonthly)-(0.45*BodyzQmonthly*Point)) && candlesizeLL3monthly>3)
           {
            LL3monthly=iHigh(NULL,PERIOD_MN1,zQmonthly);
            if(LL3monthly>minLL3monthly)minLL3monthly=LL3monthly;
            ObjectCreate("ML LL3 Candid W3monthly-"+zQmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_MN1,zQmonthly),iHigh(NULL,PERIOD_MN1,zQmonthly));
            ObjectSet("ML LL3 Candid W3monthly-"+zQmonthly,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML LL3 Candid W3monthly-"+zQmonthly,OBJPROP_COLOR,Brown);
            ObjectSet("ML LL3 Candid W3monthly-"+zQmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
           }

         zQmonthly++;
        }

      if(minLL3monthly==minLL2monthly || minLL3monthly<=LLmonthly-((LLmonthly-minLL2monthly)/variable2))
        {
         int shoroLQQmonthly=iBarShift(NULL,PERIOD_W1,iTime(NULL,PERIOD_MN1,q));
         ObjectCreate("ML shoroLD1QQmonthly-"+shoroLQQmonthly,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,shoroLQQmonthly-1),iLow(NULL,PERIOD_W1,shoroLQQmonthly-1));
         ObjectSet("ML shoroLD1QQmonthly-"+shoroLQQmonthly,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroLD1QQmonthly-"+shoroLQQmonthly,OBJPROP_COLOR,Red);
         ObjectSet("ML shoroLD1QQmonthly-"+shoroLQQmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);

         int zQQmonthly=q;
         int nzQQmonthly=q;
         int countQQmonthly=0;
         double BodyzQQmonthly;
         double upshadowzQQmonthly;
         double downshadowzQQmonthly;

         while(zQQmonthly<(iBars(NULL,PERIOD_W1)-1) && countQQmonthly<=MaxTPSLCalcmonthly && countQQmonthly<=iBars(NULL,PERIOD_W1)-2-zQQmonthly)
           {
            if(iClose(NULL,PERIOD_W1,zQQmonthly)>iOpen(NULL,PERIOD_W1,zQQmonthly))
              {
               upshadowzQQmonthly=MathAbs((iHigh(NULL,PERIOD_W1,zQQmonthly)-iClose(NULL,PERIOD_W1,zQQmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zQQmonthly)<iOpen(NULL,PERIOD_W1,zQQmonthly))
              {
               upshadowzQQmonthly=MathAbs((iHigh(NULL,PERIOD_W1,zQQmonthly)-iOpen(NULL,PERIOD_W1,zQQmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zQQmonthly)>iOpen(NULL,PERIOD_W1,zQQmonthly))
              {
               downshadowzQQmonthly=MathAbs((iLow(NULL,PERIOD_W1,zQQmonthly)-iOpen(NULL,PERIOD_W1,zQQmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zQQmonthly)<iOpen(NULL,PERIOD_W1,zQQmonthly))
              {
               downshadowzQQmonthly=MathAbs((iLow(NULL,PERIOD_W1,zQQmonthly)-iClose(NULL,PERIOD_W1,zQQmonthly)+(1*Point))/Point);
              }

            BodyzQQmonthly=MathAbs(iClose(NULL,PERIOD_W1,zQQmonthly)-iOpen(NULL,PERIOD_W1,zQQmonthly))/Point;

            int nLL3Qmonthly=zQQmonthly;
            int MaxNLL3Qmonthly=zQQmonthly;
            double MaxBodyLL3Qmonthly=zQQmonthly;
            while(nLL3Qmonthly<(nOfCandleWmonthly+zQQmonthly))
              {
               double BodyLL3Qmonthly=((iOpen(NULL,PERIOD_W1,nLL3Qmonthly)-iClose(NULL,PERIOD_W1,nLL3Qmonthly))/Point);
               double dyLL3Qmonthly=MathAbs(BodyLL3Qmonthly);
               if(dyLL3Qmonthly>MaxBodyLL3Qmonthly)
                 {
                  MaxBodyLL3Qmonthly=dyLL3Qmonthly;
                  MaxNLL3Qmonthly=nLL3Qmonthly;
                 }
               nLL3Qmonthly++;
              }

            int n2LL3Qmonthly=zQQmonthly;
            int MaxN2LL3Qmonthly=zQQmonthly;
            double MaxBody2LL3Qmonthly=zQQmonthly;
            while(n2LL3Qmonthly<(nOfCandleWmonthly+zQQmonthly))
              {
               double Body2LL3Qmonthly=((iOpen(NULL,PERIOD_W1,n2LL3Qmonthly)-iClose(NULL,PERIOD_W1,n2LL3Qmonthly))/Point);
               double dy2LL3Qmonthly=MathAbs(Body2LL3Qmonthly);
               if(dy2LL3Qmonthly<MaxBodyLL3Qmonthly && dy2LL3Qmonthly>MaxBody2LL3Qmonthly)
                 {
                  MaxBody2LL3Qmonthly=dy2LL3Qmonthly;
                  MaxN2LL3Qmonthly=n2LL3Qmonthly;
                 }
               n2LL3Qmonthly++;
              }

            double darsadLL3Qmonthly=(BodyzQQmonthly/((MaxBodyLL3Qmonthly+MaxBody2LL3Qmonthly)/2))*100;

            double candlesizeLL3Qmonthly;
            if(darsadLL3Qmonthly>=59)
               candlesizeLL3Qmonthly=4;
            if(darsadLL3Qmonthly<59 && darsadLL3Qmonthly>=39)
               candlesizeLL3Qmonthly=3;
            if(darsadLL3Qmonthly<39 && darsadLL3Qmonthly>5)
               candlesizeLL3Qmonthly=2;
            if(darsadLL3Qmonthly<=5)
               candlesizeLL3Qmonthly=1;

            if(iHigh(NULL,PERIOD_W1,zQQmonthly)<LLmonthly-((TLmonthly-LLmonthly)/variable) && iHigh(NULL,PERIOD_W1,zQQmonthly)>minLL2monthly && candlesizeLL3Qmonthly<3 && upshadowzQQmonthly>=BodyzQQmonthly)
              {
               LL3=iHigh(NULL,PERIOD_W1,zQQmonthly);
               if(LL3monthly>minLL3monthly)minLL3monthly=LL3monthly;
               ObjectCreate("ML LL3Q Candid W1monthly-"+zQQmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zQQmonthly),iHigh(NULL,PERIOD_W1,zQQmonthly));
               ObjectSet("ML LL3Q Candid W1monthly-"+zQQmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL3Q Candid W1monthly-"+zQQmonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL3Q Candid W1monthly-"+zQQmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }
            if(iHigh(NULL,PERIOD_W1,zQQmonthly)<LLmonthly-((TLmonthly-LLmonthly)/variable) && candlesizeLL3Qmonthly>3 && iHigh(NULL,PERIOD_W1,zQQmonthly)>minLL2monthly && upshadowzQQmonthly>=(BodyzQQmonthly/4))
              {
               LL3monthly=iHigh(NULL,PERIOD_W1,zQQmonthly);
               if(LL3monthly>minLL3monthly)minLL3monthly=LL3monthly;
               ObjectCreate("ML LL3Q Candid W2monthly-"+zQQmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zQQmonthly),iHigh(NULL,PERIOD_W1,zQQmonthly));
               ObjectSet("ML LL3Q Candid W2monthly-"+zQQmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL3Q Candid W2monthly-"+zQQmonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL3Q Candid W2monthly-"+zQQmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }
            if(iHigh(NULL,PERIOD_W1,zQQmonthly)<LLmonthly-((TLmonthly-LLmonthly)/variable) && iHigh(NULL,PERIOD_W1,zQQmonthly)>minLL2monthly && iClose(NULL,PERIOD_W1,zQQmonthly)>iOpen(NULL,PERIOD_W1,zQQmonthly) && iLow(NULL,PERIOD_W1,(zQQmonthly-1))<(iClose(NULL,PERIOD_W1,zQQmonthly)-(0.45*BodyzQQmonthly*Point)) && candlesizeLL3Qmonthly>3)
              {
               LL3monthly=iHigh(NULL,PERIOD_W1,zQQmonthly);
               if(LL3monthly>minLL3monthly)minLL3monthly=LL3monthly;
               ObjectCreate("ML LL3Q Candid W3monthly-"+zQQmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zQQmonthly),iHigh(NULL,PERIOD_W1,zQQmonthly));
               ObjectSet("ML LL3Q Candid W3monthly-"+zQQmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL3Q Candid W3monthly-"+zQQmonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL3Q Candid W3monthly-"+zQQmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }

            zQQmonthly++;
           }

        }

      if(minLL3monthly==minLL2monthly || minLL3monthly<=LLmonthly-((LLmonthly-minLL2monthly)/variable2))
        {
         int shoroLQQQmonthly=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q));
         ObjectCreate("ML shoroLD1QQQmonthly-"+shoroLQQQmonthly,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,shoroLQQQmonthly-1),iLow(NULL,PERIOD_D1,shoroLQQQmonthly-1));
         ObjectSet("ML shoroLD1QQQmonthly-"+shoroLQQQmonthly,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroLD1QQQmonthly-"+shoroLQQQmonthly,OBJPROP_COLOR,Red);
         ObjectSet("ML shoroLD1QQQmonthly-"+shoroLQQQmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);

         int zQQQmonthly=q;
         int nzQQQmonthly=q;
         int countQQQmonthly=0;
         double BodyzQQQmonthly;
         double upshadowzQQQmonthly;
         double downshadowzQQQmonthly;

         while(zQQQmonthly<(iBars(NULL,PERIOD_D1)-1) && countQQQmonthly<=MaxTPSLCalcmonthly && countQQQmonthly<=iBars(NULL,PERIOD_D1)-2-zQQQmonthly)
           {
            if(iClose(NULL,PERIOD_D1,zQQQmonthly)>iOpen(NULL,PERIOD_D1,zQQQmonthly))
              {
               upshadowzQQQmonthly=MathAbs((iHigh(NULL,PERIOD_D1,zQQQmonthly)-iClose(NULL,PERIOD_D1,zQQQmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_D1,zQQQmonthly)<iOpen(NULL,PERIOD_D1,zQQQmonthly))
              {
               upshadowzQQQmonthly=MathAbs((iHigh(NULL,PERIOD_D1,zQQQmonthly)-iOpen(NULL,PERIOD_D1,zQQQmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_D1,zQQQmonthly)>iOpen(NULL,PERIOD_D1,zQQQmonthly))
              {
               downshadowzQQQmonthly=MathAbs((iLow(NULL,PERIOD_D1,zQQQmonthly)-iOpen(NULL,PERIOD_D1,zQQQmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_D1,zQQQmonthly)<iOpen(NULL,PERIOD_D1,zQQQmonthly))
              {
               downshadowzQQQmonthly=MathAbs((iLow(NULL,PERIOD_D1,zQQQmonthly)-iClose(NULL,PERIOD_D1,zQQQmonthly)+(1*Point))/Point);
              }

            BodyzQQQmonthly=MathAbs(iClose(NULL,PERIOD_D1,zQQQmonthly)-iOpen(NULL,PERIOD_D1,zQQQmonthly))/Point;

            int nLL3QQmonthly=zQQQmonthly;
            int MaxNLL3QQmonthly=zQQQmonthly;
            double MaxBodyLL3QQmonthly=zQQQmonthly;
            while(nLL3QQmonthly<(nOfCandleWmonthly+zQQQmonthly))
              {
               double BodyLL3QQmonthly=((iOpen(NULL,PERIOD_D1,nLL3QQmonthly)-iClose(NULL,PERIOD_D1,nLL3QQmonthly))/Point);
               double dyLL3QQmonthly=MathAbs(BodyLL3QQmonthly);
               if(dyLL3Qmonthly>MaxBodyLL3QQmonthly)
                 {
                  MaxBodyLL3QQmonthly=dyLL3QQmonthly;
                  MaxNLL3QQmonthly=nLL3QQmonthly;
                 }
               nLL3QQmonthly++;
              }

            int n2LL3QQmonthly=zQQQmonthly;
            int MaxN2LL3QQmonthly=zQQQmonthly;
            double MaxBody2LL3QQmonthly=zQQQmonthly;
            while(n2LL3QQmonthly<(nOfCandleWmonthly+zQQQmonthly))
              {
               double Body2LL3QQmonthly=((iOpen(NULL,PERIOD_D1,n2LL3QQmonthly)-iClose(NULL,PERIOD_D1,n2LL3QQmonthly))/Point);
               double dy2LL3QQmonthly=MathAbs(Body2LL3QQmonthly);
               if(dy2LL3QQmonthly<MaxBodyLL3QQmonthly && dy2LL3QQmonthly>MaxBody2LL3QQmonthly)
                 {
                  MaxBody2LL3QQmonthly=dy2LL3QQmonthly;
                  MaxN2LL3QQmonthly=n2LL3QQmonthly;
                 }
               n2LL3QQmonthly++;
              }

            double darsadLL3QQmonthly=(BodyzQQQmonthly/((MaxBodyLL3QQmonthly+MaxBody2LL3QQmonthly)/2))*100;

            double candlesizeLL3QQmonthly;
            if(darsadLL3QQmonthly>=59)
               candlesizeLL3QQmonthly=4;
            if(darsadLL3QQmonthly<59 && darsadLL3QQmonthly>=39)
               candlesizeLL3QQmonthly=3;
            if(darsadLL3QQmonthly<39 && darsadLL3QQmonthly>5)
               candlesizeLL3QQmonthly=2;
            if(darsadLL3QQmonthly<=5)
               candlesizeLL3QQmonthly=1;

            if(iHigh(NULL,PERIOD_D1,zQQQmonthly)<LLmonthly-((TLmonthly-LLmonthly)/variable) && iHigh(NULL,PERIOD_D1,zQQQmonthly)>LL2monthly && candlesizeLL3QQmonthly<3 && upshadowzQQQmonthly>=BodyzQQQmonthly)
              {
               LL3monthly=iHigh(NULL,PERIOD_D1,zQQQmonthly);
               if(LL3monthly>minLL3monthly)minLL3monthly=LL3monthly;
               ObjectCreate("ML LL3QQ Candid W1monthly-"+zQQQmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zQQQmonthly),iHigh(NULL,PERIOD_D1,zQQQmonthly));
               ObjectSet("ML LL3QQ Candid W1monthly-"+zQQQmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL3QQ Candid W1monthly-"+zQQQmonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL3QQ Candid W1monthly-"+zQQQmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
              }
            if(iHigh(NULL,PERIOD_D1,zQQQmonthly)<LLmonthly-((TLmonthly-LLmonthly)/variable) && candlesizeLL3QQmonthly>3 && iHigh(NULL,PERIOD_D1,zQQQmonthly)>LL2monthly && upshadowzQQQmonthly>=(BodyzQQQmonthly/4))
              {
               LL3monthly=iHigh(NULL,PERIOD_D1,zQQQmonthly);
               if(LL3monthly>minLL3monthly)minLL3monthly=LL3monthly;
               ObjectCreate("ML LL3QQ Candid W2monthly-"+zQQQmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zQQQmonthly),iHigh(NULL,PERIOD_D1,zQQQmonthly));
               ObjectSet("ML LL3QQ Candid W2monthly-"+zQQQmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL3QQ Candid W2monthly-"+zQQQmonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL3QQ Candid W2monthly-"+zQQQmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
              }
            if(iHigh(NULL,PERIOD_D1,zQQQmonthly)<LLmonthly-((TLmonthly-LLmonthly)/variable) && iHigh(NULL,PERIOD_D1,zQQQmonthly)>LL2monthly && iClose(NULL,PERIOD_D1,zQQQmonthly)>iOpen(NULL,PERIOD_D1,zQQQmonthly) && iLow(NULL,PERIOD_D1,(zQQQmonthly-1))<(iClose(NULL,PERIOD_D1,zQQQmonthly)-(0.45*BodyzQQQmonthly*Point)) && candlesizeLL3QQmonthly>3)
              {
               LL3monthly=iHigh(NULL,PERIOD_D1,zQQQmonthly);
               if(LL3monthly>minLL3monthly)minLL3monthly=LL3monthly;
               ObjectCreate("ML LL3QQ Candid W3monthly-"+zQQQmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zQQQmonthly),iHigh(NULL,PERIOD_D1,zQQQmonthly));
               ObjectSet("ML LL3QQ Candid W3monthly-"+zQQQmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL3QQ Candid W3monthly-"+zQQQmonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL3QQ Candid W3monthly-"+zQQQmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
              }

            zQQQmonthly++;
           }

        }

      int zVmonthly=q;
      int nzVmonthly=q;
      int countVmonthly=0;
      double BodyzVmonthly;
      double upshadowzVmonthly;
      double downshadowzVmonthly;
      minLL4monthly=minLL2monthly-(TLmonthly-LLmonthly);

      while(zVmonthly<(iBars(NULL,PERIOD_MN1)-1) && countVmonthly<=MaxTPSLCalcmonthly && countVmonthly<=iBars(NULL,PERIOD_MN1)-2-zVmonthly)
        {
         if(iClose(NULL,PERIOD_MN1,zVmonthly)>iOpen(NULL,PERIOD_MN1,zVmonthly))
           {
            upshadowzVmonthly=MathAbs((iHigh(NULL,PERIOD_MN1,zVmonthly)-iClose(NULL,PERIOD_MN1,zVmonthly)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_MN1,zVmonthly)<iOpen(NULL,PERIOD_MN1,zVmonthly))
           {
            upshadowzVmonthly=MathAbs((iHigh(NULL,PERIOD_MN1,zVmonthly)-iOpen(NULL,PERIOD_MN1,zVmonthly)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_MN1,zVmonthly)>iOpen(NULL,PERIOD_MN1,zVmonthly))
           {
            downshadowzVmonthly=MathAbs((iLow(NULL,PERIOD_MN1,zVmonthly)-iOpen(NULL,PERIOD_MN1,zVmonthly)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_MN1,zVmonthly)<iOpen(NULL,PERIOD_MN1,zVmonthly))
           {
            downshadowzVmonthly=MathAbs((iLow(NULL,PERIOD_MN1,zVmonthly)-iClose(NULL,PERIOD_MN1,zVmonthly)+(1*Point))/Point);
           }

         BodyzVmonthly=MathAbs(iClose(NULL,PERIOD_MN1,zVmonthly)-iOpen(NULL,PERIOD_MN1,zVmonthly))/Point;

         int nLL4monthly=zVmonthly;
         int MaxNLL4monthly=zVmonthly;
         double MaxBodyLL4monthly=zVmonthly;
         while(nLL4monthly<(nOfCandleWmonthly+zVmonthly))
           {
            double BodyLL4monthly=((iOpen(NULL,PERIOD_MN1,nLL4monthly)-iClose(NULL,PERIOD_MN1,nLL4monthly))/Point);
            double dyLL4monthly=MathAbs(BodyLL4monthly);
            if(dyLL4monthly>MaxBodyLL4monthly)
              {
               MaxBodyLL4monthly=dyLL4monthly;
               MaxNLL4monthly=nLL4monthly;
              }
            nLL4monthly++;
           }

         int n2LL4monthly=zVmonthly;
         int MaxN2LL4monthly=zVmonthly;
         double MaxBody2LL4monthly=zVmonthly;
         while(n2LL4monthly<(nOfCandleWmonthly+zVmonthly))
           {
            double Body2LL4monthly=((iOpen(NULL,PERIOD_MN1,n2LL4monthly)-iClose(NULL,PERIOD_MN1,n2LL4monthly))/Point);
            double dy2LL4monthly=MathAbs(Body2LL4monthly);
            if(dy2LL4monthly<MaxBodyLL4monthly && dy2LL4monthly>MaxBody2LL4monthly)
              {
               MaxBody2LL4monthly=dy2LL4monthly;
               MaxN2LL4monthly=n2LL4monthly;
              }
            n2LL4monthly++;
           }

         double darsadLL4monthly=(BodyzVmonthly/((MaxBodyLL4monthly+MaxBody2LL4monthly)/2))*100;

         double candlesizeLL4monthly;
         if(darsadLL4monthly>=59)
            candlesizeLL4monthly=4;
         if(darsadLL4monthly<59 && darsadLL4monthly>=39)
            candlesizeLL4monthly=3;
         if(darsadLL4monthly<39 && darsadLL4monthly>5)
            candlesizeLL4monthly=2;
         if(darsadLL4monthly<=5)
            candlesizeLL4monthly=1;

         if(iHigh(NULL,PERIOD_MN1,zVmonthly)<minLL2monthly-((TLmonthly-LLmonthly)/variable) && iHigh(NULL,PERIOD_MN1,zVmonthly)>(minLL2monthly-(TLmonthly-LLmonthly)) && candlesizeLL4monthly<3 && upshadowzVmonthly>=BodyzVmonthly)
           {
            LL4monthly=iHigh(NULL,PERIOD_MN1,zVmonthly);
            if(LL4monthly>minLL4monthly)minLL4monthly=LL4monthly;
            ObjectCreate("ML LL4 Candid W1monthly-"+zVmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_MN1,zVmonthly),iLow(NULL,PERIOD_MN1,zVmonthly));
            ObjectSet("ML LL4 Candid W1monthly-"+zVmonthly,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML LL4 Candid W1monthly-"+zVmonthly,OBJPROP_COLOR,Brown);
            ObjectSet("ML LL4 Candid W1monthly-"+zVmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
           }
         if(iHigh(NULL,PERIOD_MN1,zVmonthly)<minLL2monthly-((TLmonthly-LLmonthly)/variable) && candlesizeLL4monthly>3 && iHigh(NULL,PERIOD_MN1,zVmonthly)>(minLL2monthly-(TLmonthly-LLmonthly)) && upshadowzVmonthly>=(BodyzVmonthly/4))
           {
            LL4monthly=iHigh(NULL,PERIOD_MN1,zVmonthly);
            if(LL4monthly>minLL4monthly)minLL4monthly=LL4monthly;
            ObjectCreate("ML LL4 Candid W2monthly-"+zVmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_MN1,zVmonthly),iHigh(NULL,PERIOD_MN1,zVmonthly));
            ObjectSet("ML LL4 Candid W2monthly-"+zVmonthly,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML LL4 Candid W2monthly-"+zVmonthly,OBJPROP_COLOR,Brown);
            ObjectSet("ML LL4 Candid W2monthly-"+zVmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
           }
         if(iHigh(NULL,PERIOD_MN1,zVmonthly)<minLL2monthly-((TLmonthly-LLmonthly)/variable) && iHigh(NULL,PERIOD_MN1,zVmonthly)>minLL2monthly-(TLmonthly-LLmonthly) && iClose(NULL,PERIOD_MN1,zVmonthly)>iOpen(NULL,PERIOD_MN1,zVmonthly) && iLow(NULL,PERIOD_MN1,(zVmonthly-1))<(iClose(NULL,PERIOD_MN1,zVmonthly)-(0.45*BodyzVmonthly*Point)) && candlesizeLL4monthly>3)
           {
            LL4monthly=iHigh(NULL,PERIOD_MN1,zVmonthly);
            if(LL4monthly>minLL4monthly)minLL4monthly=LL4monthly;
            ObjectCreate("ML LL4 Candid W3monthly-"+zVmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_MN1,zVmonthly),iHigh(NULL,PERIOD_MN1,zVmonthly));
            ObjectSet("ML LL4 Candid W3monthly-"+zVmonthly,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML LL4 Candid W3monthly-"+zVmonthly,OBJPROP_COLOR,Brown);
            ObjectSet("ML LL4 Candid W3monthly-"+zVmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
           }

         zVmonthly++;
        }

      if(minLL4monthly==minLL2monthly-(TLmonthly-LLmonthly) || minLL4monthly<=minLL2monthly-((LLmonthly-minLL2monthly)/variable2))
        {
         int shoroLVVmonthly=iBarShift(NULL,PERIOD_W1,iTime(NULL,PERIOD_MN1,q));
         ObjectCreate("ML shoroLD1VVmonthly-"+shoroLVVmonthly,OBJ_VLINE,0,iTime(NULL,PERIOD_W1,shoroLVVmonthly-1),iLow(NULL,PERIOD_W1,shoroLVVmonthly-1));
         ObjectSet("ML shoroLD1VVmonthly-"+shoroLVVmonthly,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroLD1VVmonthly-"+shoroLVVmonthly,OBJPROP_COLOR,Red);
         ObjectSet("ML shoroLD1VVmonthly-"+shoroLVVmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);

         int zVVmonthly=q;
         int nzVVmonthly=q;
         int countVVmonthly=0;
         double BodyzVVmonthly;
         double upshadowzVVmonthly;
         double downshadowzVVmonthly;

         while(zVVmonthly<(iBars(NULL,PERIOD_W1)-1) && countVVmonthly<=MaxTPSLCalcmonthly && countVVmonthly<=iBars(NULL,PERIOD_W1)-2-zVVmonthly)
           {
            if(iClose(NULL,PERIOD_W1,zVVmonthly)>iOpen(NULL,PERIOD_W1,zVVmonthly))
              {
               upshadowzVVmonthly=MathAbs((iHigh(NULL,PERIOD_W1,zVVmonthly)-iClose(NULL,PERIOD_W1,zVVmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zVVmonthly)<iOpen(NULL,PERIOD_W1,zVVmonthly))
              {
               upshadowzVVmonthly=MathAbs((iHigh(NULL,PERIOD_W1,zVVmonthly)-iOpen(NULL,PERIOD_W1,zVVmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zVVmonthly)>iOpen(NULL,PERIOD_W1,zVVmonthly))
              {
               downshadowzVVmonthly=MathAbs((iLow(NULL,PERIOD_W1,zVVmonthly)-iOpen(NULL,PERIOD_W1,zVVmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_W1,zVVmonthly)<iOpen(NULL,PERIOD_W1,zVVmonthly))
              {
               downshadowzVVmonthly=MathAbs((iLow(NULL,PERIOD_W1,zVVmonthly)-iClose(NULL,PERIOD_W1,zVVmonthly)+(1*Point))/Point);
              }

            BodyzVVmonthly=MathAbs(iClose(NULL,PERIOD_W1,zVVmonthly)-iOpen(NULL,PERIOD_W1,zVVmonthly))/Point;

            int nLL4Vmonthly=zVVmonthly;
            int MaxNLL4Vmonthly=zVVmonthly;
            double MaxBodyLL4Vmonthly=zVVmonthly;
            while(nLL4Vmonthly<(nOfCandleWmonthly+zVVmonthly))
              {
               double BodyLL4Vmonthly=((iOpen(NULL,PERIOD_W1,nLL4Vmonthly)-iClose(NULL,PERIOD_W1,nLL4Vmonthly))/Point);
               double dyLL4Vmonthly=MathAbs(BodyLL4Vmonthly);
               if(dyLL4Vmonthly>MaxBodyLL4Vmonthly)
                 {
                  MaxBodyLL4Vmonthly=dyLL4Vmonthly;
                  MaxNLL4Vmonthly=nLL4Vmonthly;
                 }
               nLL4Vmonthly++;
              }

            int n2LL4Vmonthly=zVVmonthly;
            int MaxN2LL4Vmonthly=zVVmonthly;
            double MaxBody2LL4Vmonthly=zVVmonthly;
            while(n2LL4Vmonthly<(nOfCandleWmonthly+zVVmonthly))
              {
               double Body2LL4Vmonthly=((iOpen(NULL,PERIOD_W1,n2LL4Vmonthly)-iClose(NULL,PERIOD_W1,n2LL4Vmonthly))/Point);
               double dy2LL4Vmonthly=MathAbs(Body2LL4Vmonthly);
               if(dy2LL4Vmonthly<MaxBodyLL4Vmonthly && dy2LL4Vmonthly>MaxBody2LL4Vmonthly)
                 {
                  MaxBody2LL4Vmonthly=dy2LL4Vmonthly;
                  MaxN2LL4Vmonthly=n2LL4Vmonthly;
                 }
               n2LL4Vmonthly++;
              }

            double darsadLL4Vmonthly=(BodyzVVmonthly/((MaxBodyLL4Vmonthly+MaxBody2LL4Vmonthly)/2))*100;

            double candlesizeLL4Vmonthly;
            if(darsadLL4Vmonthly>=59)
               candlesizeLL4Vmonthly=4;
            if(darsadLL4Vmonthly<59 && darsadLL4Vmonthly>=39)
               candlesizeLL4Vmonthly=3;
            if(darsadLL4Vmonthly<39 && darsadLL4Vmonthly>5)
               candlesizeLL4Vmonthly=2;
            if(darsadLL4Vmonthly<=5)
               candlesizeLL4Vmonthly=1;

            if(iHigh(NULL,PERIOD_W1,zVVmonthly)<minLL2monthly-((TLmonthly-LLmonthly)/variable) && iHigh(NULL,PERIOD_W1,zVVmonthly)>minLL2monthly-(TLmonthly-LLmonthly) && candlesizeLL4Vmonthly<3 && upshadowzVVmonthly>=BodyzVVmonthly)
              {
               LL4monthly=iHigh(NULL,PERIOD_W1,zVVmonthly);
               if(LL4monthly>minLL4monthly)minLL4monthly=LL4monthly;
               ObjectCreate("ML LL4V Candid W1monthly-"+zVVmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zVVmonthly),iHigh(NULL,PERIOD_W1,zVVmonthly));
               ObjectSet("ML LL4V Candid W1monthly-"+zVVmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL4V Candid W1monthly-"+zVVmonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL4V Candid W1monthly-"+zVVmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }
            if(iHigh(NULL,PERIOD_W1,zVVmonthly)<minLL2monthly-((TLmonthly-LLmonthly)/variable) && candlesizeLL4Vmonthly>3 && iHigh(NULL,PERIOD_W1,zVVmonthly)>minLL2monthly-(TLmonthly-LLmonthly) && upshadowzVVmonthly>=(BodyzVVmonthly/4))
              {
               LL4monthly=iHigh(NULL,PERIOD_W1,zVVmonthly);
               if(LL4monthly>minLL4monthly)minLL4monthly=LL4monthly;
               ObjectCreate("ML LL4V Candid W2monthly-"+zVVmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zVVmonthly),iHigh(NULL,PERIOD_W1,zVVmonthly));
               ObjectSet("ML LL4V Candid W2monthly-"+zVVmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL4V Candid W2monthly-"+zVVmonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL4V Candid W2monthly-"+zVVmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }
            if(iHigh(NULL,PERIOD_W1,zVVmonthly)<minLL2monthly-((TLmonthly-LLmonthly)/variable) && iHigh(NULL,PERIOD_W1,zVVmonthly)>minLL2monthly-(TLmonthly-LLmonthly) && iClose(NULL,PERIOD_W1,zVVmonthly)>iOpen(NULL,PERIOD_W1,zVVmonthly) && iLow(NULL,PERIOD_W1,(zVVmonthly-1))<(iClose(NULL,PERIOD_W1,zVVmonthly)-(0.45*BodyzVVmonthly*Point)) && candlesizeLL4Vmonthly>3)
              {
               LL4monthly=iHigh(NULL,PERIOD_W1,zVVmonthly);
               if(LL4monthly>minLL4monthly)minLL4monthly=LL4monthly;
               ObjectCreate("ML LL4V Candid W3monthly-"+zVVmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_W1,zVVmonthly),iHigh(NULL,PERIOD_W1,zVV));
               ObjectSet("ML LL4V Candid W3monthly-"+zVVmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL4V Candid W3monthly-"+zVVmonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL4V Candid W3monthly-"+zVVmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
              }

            zVVmonthly++;
           }

        }

      if(minLL4monthly==minLL2monthly-(TLmonthly-LLmonthly) || minLL4monthly<=minLL2monthly-((LLmonthly-minLL2monthly)/variable2))
        {
         int shoroLVVVmonthly=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q));
         ObjectCreate("ML shoroLD1VVVmonthly-"+shoroLVVVmonthly,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,shoroLVVVmonthly-1),iLow(NULL,PERIOD_D1,shoroLVVVmonthly-1));
         ObjectSet("ML shoroLD1VVVmonthly-"+shoroLVVVmonthly,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroLD1VVVmonthly-"+shoroLVVVmonthly,OBJPROP_COLOR,Red);
         ObjectSet("ML shoroLD1VVVmonthly-"+shoroLVVVmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);

         int zVVVmonthly=q;
         int nzVVVmonthly=q;
         int countVVVmonthly=0;
         double BodyzVVVmonthly;
         double upshadowzVVVmonthly;
         double downshadowzVVVmonthly;

         while(zVVVmonthly<(iBars(NULL,PERIOD_D1)-1) && countVVVmonthly<=MaxTPSLCalcmonthly && countVVVmonthly<=iBars(NULL,PERIOD_D1)-2-zVVVmonthly)
           {
            if(iClose(NULL,PERIOD_D1,zVVVmonthly)>iOpen(NULL,PERIOD_D1,zVVVmonthly))
              {
               upshadowzVVVmonthly=MathAbs((iHigh(NULL,PERIOD_D1,zVVVmonthly)-iClose(NULL,PERIOD_D1,zVVVmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_D1,zVVVmonthly)<iOpen(NULL,PERIOD_D1,zVVVmonthly))
              {
               upshadowzVVVmonthly=MathAbs((iHigh(NULL,PERIOD_D1,zVVVmonthly)-iOpen(NULL,PERIOD_D1,zVVVmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_D1,zVVVmonthly)>iOpen(NULL,PERIOD_D1,zVVVmonthly))
              {
               downshadowzVVVmonthly=MathAbs((iLow(NULL,PERIOD_D1,zVVVmonthly)-iOpen(NULL,PERIOD_D1,zVVVmonthly)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_D1,zVVVmonthly)<iOpen(NULL,PERIOD_D1,zVVVmonthly))
              {
               downshadowzVVVmonthly=MathAbs((iLow(NULL,PERIOD_D1,zVVVmonthly)-iClose(NULL,PERIOD_D1,zVVVmonthly)+(1*Point))/Point);
              }

            BodyzVVVmonthly=MathAbs(iClose(NULL,PERIOD_D1,zVVVmonthly)-iOpen(NULL,PERIOD_D1,zVVVmonthly))/Point;

            int nLL4VVmonthly=zVVVmonthly;
            int MaxNLL4VVmonthly=zVVVmonthly;
            double MaxBodyLL4VVmonthly=zVVVmonthly;
            while(nLL4VVmonthly<(nOfCandleWmonthly+zVVVmonthly))
              {
               double BodyLL4VVmonthly=((iOpen(NULL,PERIOD_D1,nLL4VVmonthly)-iClose(NULL,PERIOD_D1,nLL4VVmonthly))/Point);
               double dyLL4VVmonthly=MathAbs(BodyLL4VVmonthly);
               if(dyLL4Vmonthly>MaxBodyLL4VVmonthly)
                 {
                  MaxBodyLL4VVmonthly=dyLL4VVmonthly;
                  MaxNLL4VVmonthly=nLL4VVmonthly;
                 }
               nLL4VVmonthly++;
              }

            int n2LL4VVmonthly=zVVVmonthly;
            int MaxN2LL4VVmonthly=zVVVmonthly;
            double MaxBody2LL4VVmonthly=zVVVmonthly;
            while(n2LL4VVmonthly<(nOfCandleWmonthly+zVVVmonthly))
              {
               double Body2LL4VVmonthly=((iOpen(NULL,PERIOD_D1,n2LL4VVmonthly)-iClose(NULL,PERIOD_D1,n2LL4VVmonthly))/Point);
               double dy2LL4VVmonthly=MathAbs(Body2LL4VVmonthly);
               if(dy2LL4VVmonthly<MaxBodyLL4VVmonthly && dy2LL4VVmonthly>MaxBody2LL4VVmonthly)
                 {
                  MaxBody2LL4VVmonthly=dy2LL4VVmonthly;
                  MaxN2LL4VVmonthly=n2LL4VVmonthly;
                 }
               n2LL4VVmonthly++;
              }

            double darsadLL4VVmonthly=(BodyzVVVmonthly/((MaxBodyLL4VVmonthly+MaxBody2LL4VVmonthly)/2))*100;

            double candlesizeLL4VVmonthly;
            if(darsadLL4VVmonthly>=59)
               candlesizeLL4VVmonthly=4;
            if(darsadLL4VVmonthly<59 && darsadLL4VVmonthly>=39)
               candlesizeLL4VVmonthly=3;
            if(darsadLL4VVmonthly<39 && darsadLL4VVmonthly>5)
               candlesizeLL4VVmonthly=2;
            if(darsadLL4VVmonthly<=5)
               candlesizeLL4VVmonthly=1;

            if(iHigh(NULL,PERIOD_D1,zVVVmonthly)<minLL2monthly-((TLmonthly-LLmonthly)/variable) && iHigh(NULL,PERIOD_D1,zVVVmonthly)>minLL2monthly-(TLmonthly-LLmonthly) && candlesizeLL4VVmonthly<3 && upshadowzVVVmonthly>=BodyzVVVmonthly)
              {
               LL4monthly=iHigh(NULL,PERIOD_D1,zVVVmonthly);
               if(LL4monthly>minLL4monthly)minLL4monthly=LL4monthly;
               ObjectCreate("ML LL4VV Candid W1monthly-"+zVVVmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zVVVmonthly),iHigh(NULL,PERIOD_D1,zVVVmonthly));
               ObjectSet("ML LL4VV Candid W1monthly-"+zVVVmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL4VV Candid W1monthly-"+zVVVmonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL4VV Candid W1monthly-"+zVVVmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
              }
            if(iHigh(NULL,PERIOD_D1,zVVVmonthly)<minLL2monthly-((TLmonthly-LLmonthly)/variable) && candlesizeLL4VVmonthly>3 && iHigh(NULL,PERIOD_D1,zVVVmonthly)>minLL2monthly-(TLmonthly-LLmonthly) && upshadowzVVVmonthly>=(BodyzVVVmonthly/4))
              {
               LL4monthly=iHigh(NULL,PERIOD_D1,zVVVmonthly);
               if(LL4monthly>minLL4monthly)minLL4monthly=LL4monthly;
               ObjectCreate("ML LL4VV Candid W2monthly-"+zVVVmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zVVVmonthly),iHigh(NULL,PERIOD_D1,zVVVmonthly));
               ObjectSet("ML LL4VV Candid W2monthly-"+zVVVmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL4VV Candid W2monthly-"+zVVVmonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL4VV Candid W2monthly-"+zVVVmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
              }
            if(iHigh(NULL,PERIOD_D1,zVVVmonthly)<minLL2monthly-((TLmonthly-LLmonthly)/variable) && iHigh(NULL,PERIOD_D1,zVVVmonthly)>minLL2monthly-(TLmonthly-LLmonthly) && iClose(NULL,PERIOD_D1,zVVVmonthly)>iOpen(NULL,PERIOD_D1,zVVVmonthly) && iLow(NULL,PERIOD_D1,(zVVVmonthly-1))<(iClose(NULL,PERIOD_D1,zVVVmonthly)-(0.45*BodyzVVVmonthly*Point)) && candlesizeLL4VVmonthly>3)
              {
               LL4monthly=iHigh(NULL,PERIOD_D1,zVVVmonthly);
               if(LL4monthly>minLL4monthly)minLL4monthly=LL4monthly;
               ObjectCreate("ML LL4VV Candid W3monthly-"+zVVVmonthly,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zVVVmonthly),iHigh(NULL,PERIOD_D1,zVVVmonthly));
               ObjectSet("ML LL4VV Candid W3monthly-"+zVVVmonthly,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL4VV Candid W3monthly-"+zVVVmonthly,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL4VV Candid W3monthly-"+zVVVmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
              }

            zVVVmonthly++;
           }

        }

      //----------Pivot Points Weekly
      pivotpointMonthly =(iHigh(NULL,PERIOD_MN1,q)+iClose(NULL,PERIOD_MN1,q)+iLow(NULL,PERIOD_MN1,q))/3;
      resistant3Monthly = iHigh(NULL,PERIOD_MN1,q)+(2*(pivotpointMonthly-iLow(NULL,PERIOD_MN1,q)));
      resistant1Monthly=2*pivotpointMonthly-iLow(NULL,PERIOD_MN1,q);
      support1Monthly=2*pivotpointMonthly-iHigh(NULL,PERIOD_MN1,q);
      resistant2Monthly=pivotpointMonthly+(resistant1Monthly-support1Monthly);
      support2Monthly = pivotpointMonthly-(resistant1Monthly-support1Monthly);
      support3Monthly = iLow(NULL,PERIOD_MN1,q)- 2*(iHigh(NULL,PERIOD_MN1,q)-pivotpointMonthly);

      ObjectCreate("ML pivotpoint",OBJ_HLINE,0,Time[0],pivotpointMonthly,0,0);
      ObjectSet("ML pivotpoint",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_D1);
      ObjectSet("ML pivotpoint",OBJPROP_COLOR,DodgerBlue);
      ObjectSet("ML pivotpoint",OBJPROP_WIDTH,1);
      ObjectSet("ML pivotpoint",OBJPROP_STYLE,STYLE_DASHDOT);

      ObjectCreate("ML resistant3",OBJ_HLINE,0,Time[0],resistant3Monthly,0,0);
      ObjectSet("ML resistant3",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_D1);
      ObjectSet("ML resistant3",OBJPROP_COLOR,DodgerBlue);
      ObjectSet("ML resistant3",OBJPROP_WIDTH,1);
      ObjectSet("ML resistant3",OBJPROP_STYLE,STYLE_DOT);

      ObjectCreate("ML resistant2",OBJ_HLINE,0,Time[0],resistant2Monthly,0,0);
      ObjectSet("ML resistant2",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_D1);
      ObjectSet("ML resistant2",OBJPROP_COLOR,DodgerBlue);
      ObjectSet("ML resistant2",OBJPROP_WIDTH,1);
      ObjectSet("ML resistant2",OBJPROP_STYLE,STYLE_DOT);

      ObjectCreate("ML resistant1",OBJ_HLINE,0,Time[0],resistant1Monthly,0,0);
      ObjectSet("ML resistant1",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_D1);
      ObjectSet("ML resistant1",OBJPROP_COLOR,DodgerBlue);
      ObjectSet("ML resistant1",OBJPROP_WIDTH,1);
      ObjectSet("ML resistant1",OBJPROP_STYLE,STYLE_DOT);

      ObjectCreate("ML support1",OBJ_HLINE,0,Time[0],support1Monthly,0,0);
      ObjectSet("ML support1",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_D1);
      ObjectSet("ML support1",OBJPROP_COLOR,DodgerBlue);
      ObjectSet("ML support1",OBJPROP_WIDTH,1);
      ObjectSet("ML support1",OBJPROP_STYLE,STYLE_DOT);

      ObjectCreate("ML support2",OBJ_HLINE,0,Time[0],support2Monthly,0,0);
      ObjectSet("ML support2",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_D1);
      ObjectSet("ML support2",OBJPROP_COLOR,DodgerBlue);
      ObjectSet("ML support2",OBJPROP_WIDTH,1);
      ObjectSet("ML support2",OBJPROP_STYLE,STYLE_DOT);

      ObjectCreate("ML support3",OBJ_HLINE,0,Time[0],support3Monthly,0,0);
      ObjectSet("ML support3",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_D1);
      ObjectSet("ML support3",OBJPROP_COLOR,DodgerBlue);
      ObjectSet("ML support3",OBJPROP_WIDTH,1);
      ObjectSet("ML support3",OBJPROP_STYLE,STYLE_DOT);

      ObjectCreate("ML TL4xmonthly",OBJ_HLINE,0,Time[0],minTL4monthly,0,0);
      ObjectSet("ML TL4xmonthly",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_D1|OBJ_PERIOD_W1);
      ObjectSet("ML TL4xmonthly",OBJPROP_COLOR,Purple);
      ObjectSet("ML TL4xmonthly",OBJPROP_WIDTH,1);
      ObjectSet("ML TL4xmonthly",OBJPROP_STYLE,STYLE_DASH);
      ObjectCreate("ML TL3xmonthly",OBJ_HLINE,0,Time[0],minTL3monthly,0,0);
      ObjectSet("ML TL3xmonthly",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_D1|OBJ_PERIOD_W1);
      ObjectSet("ML TL3xmonthly",OBJPROP_COLOR,Orange);
      ObjectSet("ML TL3xmonthly",OBJPROP_WIDTH,1);
      ObjectSet("ML TL3xmonthly",OBJPROP_STYLE,STYLE_DASH);
      ObjectCreate("ML LL3Qmonthly",OBJ_HLINE,0,Time[0],minLL3monthly,0,0);
      ObjectSet("ML LL3Qmonthly",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_D1|OBJ_PERIOD_W1);
      ObjectSet("ML LL3Qmonthly",OBJPROP_COLOR,Orange);
      ObjectSet("ML LL3Qmonthly",OBJPROP_WIDTH,1);
      ObjectSet("ML LL3Qmonthly",OBJPROP_STYLE,STYLE_DASH);
      ObjectCreate("ML LL4Qmonthly",OBJ_HLINE,0,Time[0],minLL4monthly,0,0);
      ObjectSet("ML LL4Qmonthly",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_D1|OBJ_PERIOD_W1);
      ObjectSet("ML LL4Qmonthly",OBJPROP_COLOR,Purple);
      ObjectSet("ML LL4Qmonthly",OBJPROP_WIDTH,1);
      ObjectSet("ML LL4Qmonthly",OBJPROP_STYLE,STYLE_DASH);

      //-----------------------------------------/

      //-----------Jadval Tahlil 1   
      string tahlilAmonthly;
      string tahlilBmonthly;

      if(dirmonthly>1 && bigmonthly>=1 && badaneh2monthly>0)
         tahlilAmonthly="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dirmonthly>1 && bigmonthly>=1 && badaneh2monthly>0)
         tahlilBmonthly="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي، شکست حد پايين";
      if(dirmonthly>1 && mediummonthly>=1 && badaneh2monthly>0)
         tahlilAmonthly="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dirmonthly>1 && mediummonthly>=1 && badaneh2monthly>0)
         tahlilBmonthly="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirmonthly>1 && smallmonthly>=1 && badaneh2monthly>0)
         tahlilAmonthly="الگو الف : کاهش تمايلات صعودي ، انتظار عدم نواسانات صعودي، شکست حد پايين";
      if(dirmonthly>1 && smallmonthly>=1 && badaneh2monthly>0)
         tahlilBmonthly="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dirmonthly>1 && spinningmonthly>=1 && badaneh2monthly>0)
         tahlilAmonthly="الگو الف : کاهش تمايلات صعودي ، انتظار عدم نواسانات صعودي، شکست حد پايين";
      if(dirmonthly>1 && spinningmonthly>=1 && badaneh2monthly>0)
         tahlilBmonthly="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";

      if(dirmonthly<1 && bigmonthly>=1 && badaneh2monthly>0)
         tahlilAmonthly="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dirmonthly<1 && bigmonthly>=1 && badaneh2monthly>0)
         tahlilBmonthly="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirmonthly<1 && mediummonthly>=1 && badaneh2monthly>0)
         tahlilAmonthly="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dirmonthly<1 && mediummonthly>=1 && badaneh2monthly>0)
         tahlilBmonthly="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirmonthly<1 && smallmonthly>=1 && badaneh2monthly>0)
         tahlilAmonthly="الگوي الف : شروع تمايلات صعودي ، انتظار نوسانات صعودي ،شکست حد بالا";
      if(dirmonthly<1 && smallmonthly>=1 && badaneh2monthly>0)
         tahlilBmonthly="الگوي ب: شروع مجدد تمايلات نزولي،انتظار نوسانات نزولي، شکست حد پايين";
      if(dirmonthly<1 && spinningmonthly>=1 && badaneh2monthly>0)
         tahlilAmonthly="الگوي الف : شروع تمايلات صعودي ، انتظار نوسانات صعودي ،شکست حد بالا";
      if(dirmonthly<1 && spinningmonthly>=1 && badaneh2monthly>0)
         tahlilBmonthly="الگوي ب: شروع مجدد تمايلات نزولي،انتظار نوسانات نزولي، شکست حد پايين";

      if(dirmonthly>1 && bigmonthly>=1 && badanehmonthly>0)
         tahlilAmonthly="الگو الف: ادامه تمايلات نزولي ، انتظار نوسانات نزولي، شکست حد پايين";
      if(dirmonthly>1 && bigmonthly>=1 && badanehmonthly>0)
         tahlilBmonthly="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dirmonthly>1 && mediummonthly>=1 && badanehmonthly>0)
         tahlilAmonthly="الگو الف: ادامه تمايلات نزولي ، انتظار نوسانات نزولي، شکست حد پايين ";
      if(dirmonthly>1 && mediummonthly>=1 && badanehmonthly>0)
         tahlilBmonthly="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا ";
      if(dirmonthly>1 && smallmonthly>=1 && badanehmonthly>0)
         tahlilAmonthly="الگو الف : شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirmonthly>1 && smallmonthly>=1 && badanehmonthly>0)
         tahlilBmonthly="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dirmonthly>1 && spinningmonthly>=1 && badanehmonthly>0)
         tahlilAmonthly="الگو الف : شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirmonthly>1 && spinningmonthly>=1 && badanehmonthly>0)
         tahlilBmonthly="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";

      if(dirmonthly<1 && bigmonthly>=1 && badanehmonthly>0)
         tahlilAmonthly="الگو الف:ادامه تمايلات نزولي ،انتظار نوسانات نزولي ،شکست حد پايين";
      if(dirmonthly<1 && bigmonthly>=1 && badanehmonthly>0)
         tahlilBmonthly="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dirmonthly<1 && mediummonthly>=1 && badanehmonthly>0)
         tahlilAmonthly="الگو الف:ادامه تمايلات نزولي ،انتظار نوسانات نزولي ،شکست حد پايين";
      if(dirmonthly<1 && mediummonthly>=1 && badanehmonthly>0)
         tahlilBmonthly="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dirmonthly<1 && smallmonthly>=1 && badanehmonthly>0)
         tahlilAmonthly="الگو الف: کاهش تمايلات نزولي ، انتظار عدم نوسانات نزولي ، شکست حد بالا";
      if(dirmonthly<1 && smallmonthly>=1 && badanehmonthly>0)
         tahlilBmonthly="الگوي ب: شروع مجدد تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirmonthly<1 && spinningmonthly>=1 && badanehmonthly>0)
         tahlilAmonthly="الگو الف: کاهش تمايلات نزولي ، انتظار عدم نوسانات نزولي ، شکست حد بالا";
      if(dirmonthly<1 && spinningmonthly>=1 && badanehmonthly>0)
         tahlilBmonthly="الگوي ب: شروع مجدد تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";

      ObjectCreate("ML direction",OBJ_LABEL,0,0,0,0,0);
      ObjectSet("ML direction",OBJPROP_CORNER,0);
      ObjectSet("ML direction",OBJPROP_XDISTANCE,1000);
      ObjectSet("ML direction",OBJPROP_YDISTANCE,20);
      ObjectSetText("ML direction",directionmonthly,12,"arial",Blue);

      ObjectCreate("ML candletype",OBJ_LABEL,0,0,0,0,0);
      ObjectSet("ML candletype",OBJPROP_CORNER,0);
      ObjectSet("ML candletype",OBJPROP_XDISTANCE,1000);
      ObjectSet("ML candletype",OBJPROP_YDISTANCE,35);
      ObjectSetText("ML candletype",candletypemonthly,12,"arial",Blue);

      ObjectCreate("ML X",OBJ_LABEL,0,0,0,0,0);
      ObjectSet("ML X",OBJPROP_CORNER,0);
      ObjectSet("ML X",OBJPROP_XDISTANCE,1000);
      ObjectSet("ML X",OBJPROP_YDISTANCE,50);
      ObjectSetText("ML X",Xmonthly,12,"arial",Blue);

      Comment("   جهت اوليه","   ",directionmonthly,"\n","   نوع کندل","   ",candletypemonthly,"\n","   ","\n  اندازه بدنه کندل مورد ارزيابي:","   ",(badanehmonthly+badaneh2monthly),"\n","  اندازه سايه بالا","     ",upshadowmonthly,"\n","  اندازه سايه پايين","    ",downshadowmonthly,"\n","\n ميانگين دو بزرگترين کندل محيط","   ",(MaxBodymonthly+MaxBody2monthly)/2,"\n   شماره بزرگترين کندل محيط:","   ",MaxNmonthly,"\n   شماره دومين کندل بزرگ محيط:","   ",MaxN2monthly,"\n  نسبت بدنه کندل مورد ارزيابي به بدنه مبنا:","   ",Totaldarsadmonthly,"\n","  نوع کندل","   ",Xmonthly,"\n","\n","   حد احتياط بالا","   ",TLmonthly,"\n","   حد احتياط پايين","   ",LLmonthly,"\n","\n",tahlilAmonthly,"\n",tahlilBmonthly);

      //--- create timer
      EventSetTimer(43200);
      //-------------------------------------------------------------------------
     }

//------------------------daily----------------------------------------
   if(typeofanalysis==1)
     {
      double Odaily= iOpen(NULL,PERIOD_D1,q);
      double Cdaily= iClose(NULL,PERIOD_D1,q);
      if(Cdaily<Odaily)
        {
         badanehdaily=(Odaily-Cdaily)/Point;
        }
      if(Cdaily>Odaily)
        {
         badaneh2daily=(Cdaily-Odaily)/Point;
        }
      if(nOfCandleWdaily>iBars(NULL,PERIOD_H4))
        {
         Alert("تعداد کندل اشتباه است");
         return(-1);
        }

      bool upshadowlenghtdaily;
      bool downshadowlenghtdaily;
      double upshadowdaily;
      double downshadowdaily;

      if(badanehdaily>0)
         candletypedaily="عرضه";
      if(badaneh2daily>0)
         candletypedaily="تقاضا";

      int ndaily=q;
      int MaxNdaily=q;
      double MaxBodydaily=q;
      while(ndaily<(nOfCandleWdaily+q))
        {
         double Bodydaily=((iOpen(NULL,PERIOD_D1,ndaily)-iClose(NULL,PERIOD_D1,ndaily))/Point);
         double dydaily=MathAbs(Bodydaily);
         if(dydaily>MaxBodydaily)
           {
            MaxBodydaily=dydaily;
            MaxNdaily=ndaily;
           }
         ndaily++;
        }

      int n2daily=q;
      int MaxN2daily=q;
      double MaxBody2daily=q;
      while(n2daily<(nOfCandleWdaily+q))
        {
         double Body2daily=((iOpen(NULL,PERIOD_D1,n2daily)-iClose(NULL,PERIOD_D1,n2daily))/Point);
         double dy2daily=MathAbs(Body2daily);
         if(dy2daily<MaxBodydaily && dy2daily>MaxBody2daily)
           {
            MaxBody2daily=dy2daily;
            MaxN2daily=n2daily;
           }
         n2daily++;
        }

      double darsaddaily=(badanehdaily/((MaxBodydaily+MaxBody2daily)/2))*100;
      double darsad2daily=(badaneh2daily/((MaxBodydaily+MaxBody2daily)/2))*100;
      double Totaldarsaddaily=(darsaddaily+darsad2daily);

      bool bigdaily=0;
      bool mediumdaily=0;
      bool smalldaily=0;
      bool spinningdaily=0;
      string Xdaily;

      if(Totaldarsaddaily>=61)
         Xdaily="بزرگ";
      if(Totaldarsaddaily<61 && Totaldarsaddaily>=41)
         Xdaily="متوسط";
      if(Totaldarsaddaily<41 && Totaldarsaddaily>5)
         Xdaily="کوچک";
      if(Totaldarsaddaily<=5)
         Xdaily="اسپينينگ";
      if(Totaldarsaddaily>=61)
        {
         bigdaily=1;
         candlesizedaily=4;
        }
      if(Totaldarsaddaily<61 && Totaldarsaddaily>=41)
        {
         mediumdaily=1;
         candlesizedaily=3;
        }
      if(Totaldarsaddaily<41 && Totaldarsaddaily>5)
        {
         smalldaily=1;
         candlesizedaily=2;
        }
      if(Totaldarsaddaily<=5)
        {
         spinningdaily=1;
         candlesizedaily=1;
        }

      if(badaneh2daily>0)
        {
         upshadowdaily=MathAbs((iHigh(NULL,PERIOD_D1,q)-iClose(NULL,PERIOD_D1,q)+(1*Point))/Point);
         downshadowdaily=MathAbs((iOpen(NULL,PERIOD_D1,q)-iLow(NULL,PERIOD_D1,q)+(1*Point))/Point);
        }
      if(badanehdaily>0)
        {
         upshadowdaily=MathAbs((iHigh(NULL,PERIOD_D1,q)-iOpen(NULL,PERIOD_D1,q)+(1*Point))/Point);
         downshadowdaily=MathAbs((iClose(NULL,PERIOD_D1,q)-iLow(NULL,PERIOD_D1,q)+(1*Point))/Point);
        }

      int dirdaily=0;
      string directiondaily;
      int cntdirdaily=0;
      int pdaily;
      for(pdaily=k+1;pdaily<=30; pdaily++)
        {
         if(iOpen(NULL,PERIOD_D1,pdaily)<iLow(NULL,PERIOD_D1,k) && cntdirdaily==0)
           {
            directiondaily="صعودی";
            dirdaily=2;
            cntdirdaily=1;
           }
         if(iOpen(NULL,PERIOD_D1,pdaily)>iHigh(NULL,PERIOD_D1,k) && cntdirdaily==0)
           {
            directiondaily="نزولی";
            dirdaily=0;
            cntdirdaily=1;
           }
        }

      if(upshadowdaily>101 && upshadowdaily>(2.5*(badaneh2daily+badanehdaily)) && candlesizedaily<3)
         upshadowlenghtdaily=1;
      if(upshadowdaily>101 && upshadowdaily>(1.5*(badaneh2daily+badanehdaily)) && candlesizedaily>=3)
         upshadowlenghtdaily=1;

      if(downshadowdaily>101 && downshadowdaily>(2.5*(badaneh2daily+badanehdaily)) && candlesizedaily<3)
         downshadowlenghtdaily=1;
      if(downshadowdaily>101 && downshadowdaily>(1.5*(badaneh2daily+badanehdaily)) && candlesizedaily>=3)
         downshadowlenghtdaily=1;

      if(upshadowlenghtdaily==1 && downshadowlenghtdaily==1 && 0.9<(upshadowdaily/downshadowdaily) && (upshadowdaily/downshadowdaily)<1.1)
        {
         Comment(upshadowdaily/downshadowdaily);
         Alert("Today is doutfull!! you should not use this week for trade on this symbol");
         return (-1);
        }

      if(bigdaily>=1 && badaneh2daily>0)
         TLdaily=iHigh(NULL,PERIOD_D1,q);
      if(bigdaily>=1 && badaneh2daily>0)
         LLdaily=(iOpen(NULL,PERIOD_D1,q)+(0.75*(badaneh2daily*Point)));

      if(upshadowlenghtdaily==1 && bigdaily>=1 && badaneh2daily>0)
         TLdaily=iHigh(NULL,PERIOD_D1,q)-(0.5*(upshadowdaily*Point));

      if(bigdaily>=1 && badanehdaily>0)
         LLdaily=iLow(NULL,PERIOD_D1,q);
      if(bigdaily>=1 && badanehdaily>0)
         TLdaily=(iClose(NULL,PERIOD_D1,q)+(0.25*(badanehdaily*Point)));
      if(downshadowlenghtdaily==1 && bigdaily>=1 && badanehdaily>0)
         LLdaily=iLow(NULL,PERIOD_D1,q)+(0.5*(downshadowdaily*Point));

      if(mediumdaily==1 && badanehdaily>0)
         LLdaily=iLow(NULL,PERIOD_D1,q);
      if(mediumdaily==1 && badanehdaily>0)
         TLdaily=(iClose(NULL,PERIOD_D1,q)+(0.5*(badanehdaily*Point)));

      if(downshadowlenghtdaily==1 && mediumdaily==1 && badanehdaily>0)
         LLdaily=iLow(NULL,PERIOD_D1,q)+(0.5*(downshadowdaily*Point));

      if(mediumdaily==1 && badaneh2daily>0)
         TLdaily=iHigh(NULL,PERIOD_D1,q);
      if(mediumdaily==1 && badaneh2daily>0)
         LLdaily=(iOpen(NULL,PERIOD_D1,q)+(0.5*(badaneh2daily*Point)));

      if(upshadowlenghtdaily==1 && mediumdaily==1 && badaneh2daily>0)
         TLdaily=iHigh(NULL,PERIOD_D1,q) -(0.5*(upshadowdaily*Point));

      if(smalldaily==1 && badaneh2daily>0 && spinningdaily==0)
         TLdaily=iHigh(NULL,PERIOD_D1,q);
      if(smalldaily==1 && badaneh2daily>0 && spinningdaily==0)
         LLdaily=iLow(NULL,PERIOD_D1,q);

      if(upshadowlenghtdaily==1 && smalldaily==1 && badaneh2daily>0 && spinningdaily==0)
         TLdaily=iHigh(NULL,PERIOD_D1,q) -(0.5*(upshadowdaily*Point));
      if(downshadowlenghtdaily==1 && smalldaily==1 && badaneh2daily>0 && spinningdaily==0)
         LLdaily=iLow(NULL,PERIOD_D1,q)+(0.5*(downshadowdaily*Point));

      if(smalldaily==1 && badanehdaily>0 && spinningdaily==0)
         LLdaily=iLow(NULL,PERIOD_D1,q);
      if(smalldaily==1 && badanehdaily>0 && spinningdaily==0)
         TLdaily=iHigh(NULL,PERIOD_D1,q);

      if(downshadowlenghtdaily==1 && smalldaily==1 && badanehdaily>0 && spinningdaily==0)
         LLdaily=iClose(NULL,PERIOD_D1,q)-(0.5*(downshadowdaily*Point));
      if(upshadowlenghtdaily==1 && smalldaily==1 && badanehdaily>0 && spinningdaily==0)
         TLdaily=iOpen(NULL,PERIOD_D1,q)+(0.5*(upshadowdaily*Point));

      if(spinningdaily==1 && badaneh2daily>0)
         TLdaily=iHigh(NULL,PERIOD_D1,q);
      if(spinningdaily==1 && badaneh2daily>0)
         LLdaily=iLow(NULL,PERIOD_D1,q);

      if(spinningdaily==1 && upshadowlenghtdaily==1 && badaneh2daily>0)
         TLdaily=iHigh(NULL,PERIOD_D1,q) -(0.5*(upshadowdaily*Point));
      if(spinningdaily==1 && downshadowlenghtdaily==1 && badaneh2daily>0)
         LLdaily=iLow(NULL,PERIOD_D1,q)+(0.5*(downshadowdaily*Point));

      if(spinningdaily==1 && badanehdaily>0)
         LLdaily=iLow(NULL,PERIOD_D1,q);
      if(spinningdaily==1 && badanehdaily>0)
         TLdaily=iHigh(NULL,PERIOD_D1,q);

      if(spinningdaily==1 && downshadowlenghtdaily==1 && badanehdaily>0)
         LLdaily=iClose(NULL,PERIOD_D1,q)-(0.5*(downshadowdaily*Point));
      if(spinningdaily==1 && upshadowlenghtdaily==1 && badanehdaily>0)
         TLdaily=iOpen(NULL,PERIOD_D1,q)+(0.5*(upshadowdaily*Point));

      double MinLimitdaily;
      if(candlesizedaily==4) MinLimitdaily=MinRateBdaily*(((NormalizeDouble(TLdaily,Digits)-NormalizeDouble(LLdaily,Digits)))/6);
      if(candlesizedaily==3) MinLimitdaily=MinRateMdaily*(((NormalizeDouble(TLdaily,Digits)-NormalizeDouble(LLdaily,Digits)))/6);
      if(candlesizedaily==2) MinLimitdaily=MinRateSdaily*(((NormalizeDouble(TLdaily,Digits)-NormalizeDouble(LLdaily,Digits)))/6);
      if(candlesizedaily==1) MinLimitdaily=MinRateSPdaily*(((NormalizeDouble(TLdaily,Digits)-NormalizeDouble(LLdaily,Digits)))/6);

      double safetylimitUdaily=MathMax((TLdaily+(MinLimit2daily*Point)),(TLdaily+MinLimitdaily));
      double safetylimitDdaily=MathMin((LLdaily-(MinLimit2daily*Point)),(LLdaily-MinLimitdaily));


      int zdaily=q;
      int nzdaily=q;
      minTL2daily=TLdaily+((TLdaily-LLdaily)*2);
      minLL2daily=LLdaily-((TLdaily-LLdaily)*2);
      minTL2Sdaily=TLdaily+((TLdaily-LLdaily)*4);
      minLL2Sdaily=LLdaily-((TLdaily-LLdaily)*4);
      int countdaily=0;
      bool mohitidaily;
      double Bodyzdaily;
      double upshadowzdaily;
      double downshadowzdaily;

      while(zdaily<(iBars(NULL,PERIOD_D1)-1) && countdaily<=MaxTPSLCalcdaily && countdaily<=iBars(NULL,PERIOD_D1)-2-zdaily)
        {
           {
            if(iHigh(NULL,PERIOD_D1,zdaily)>LLdaily && iLow(NULL,PERIOD_D1,zdaily)<TLdaily)
              {
               mohitidaily=1;
               countdaily++;
               ObjectCreate("ML MohitiTW-"+zdaily,OBJ_ARROW_CHECK,0,iTime(NULL,PERIOD_D1,zdaily),iLow(NULL,PERIOD_D1,zdaily));
               ObjectSet("ML MohitiTW-"+zdaily,OBJPROP_COLOR,Purple);
               ObjectSet("ML MohitiTW-"+zdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
              }
            else mohitidaily=0;
           }

         if(mohitidaily==1)
           {
            if((iHigh(NULL,PERIOD_D1,zdaily)>TLdaily && iOpen(NULL,PERIOD_D1,zdaily)<TLdaily))
              {

               if(iClose(NULL,PERIOD_D1,zdaily)>iOpen(NULL,PERIOD_D1,zdaily))
                 {
                  upshadowzdaily=MathAbs((iHigh(NULL,PERIOD_D1,zdaily)-iClose(NULL,PERIOD_D1,zdaily)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_D1,zdaily)<iOpen(NULL,PERIOD_D1,zdaily))
                 {
                  upshadowzdaily=MathAbs((iHigh(NULL,PERIOD_D1,zdaily)-iOpen(NULL,PERIOD_D1,zdaily)+(1*Point))/Point);
                 }

               Bodyzdaily=MathAbs(iClose(NULL,PERIOD_D1,zdaily)-iOpen(NULL,PERIOD_D1,zdaily))/Point;
               int nTL2daily=zdaily;
               int MaxNTL2daily=zdaily;
               double MaxBodyTL2daily=zdaily;
               while(nTL2daily<(nOfCandleWdaily+zdaily))
                 {
                  double BodyTL2daily=((iOpen(NULL,PERIOD_D1,nTL2daily)-iClose(NULL,PERIOD_D1,nTL2daily))/Point);
                  double dyTL2daily=MathAbs(BodyTL2daily);
                  if(dyTL2daily>MaxBodyTL2daily)
                    {
                     MaxBodyTL2daily=dyTL2daily;
                     MaxNTL2daily=nTL2daily;
                    }
                  nTL2daily++;
                 }

               int n2TL2daily=zdaily;
               int MaxN2TL2daily=zdaily;
               double MaxBody2TL2daily=zdaily;
               while(n2TL2daily<(nOfCandleWdaily+zdaily))
                 {
                  double Body2TL2daily=((iOpen(NULL,PERIOD_D1,n2TL2daily)-iClose(NULL,PERIOD_D1,n2TL2daily))/Point);
                  double dy2TL2daily=MathAbs(Body2TL2daily);
                  if(dy2TL2daily<MaxBodyTL2daily && dy2TL2daily>MaxBody2TL2daily)
                    {
                     MaxBody2TL2daily=dy2TL2daily;
                     MaxN2TL2daily=n2TL2daily;
                    }
                  n2TL2daily++;
                 }

               double darsadTL2daily=(Bodyzdaily/((MaxBodyTL2daily+MaxBody2TL2daily)/2))*100;

               double candlesizeTL2daily;
               if(darsadTL2daily>=61)
                  candlesizeTL2daily=4;
               if(darsadTL2daily<61 && darsadTL2daily>=41)
                  candlesizeTL2daily=3;
               if(darsadTL2daily<41 && darsadTL2daily>5)
                  candlesizeTL2daily=2;
               if(darsadTL2daily<=5)
                  candlesizeTL2daily=1;

               if(iClose(NULL,PERIOD_D1,zdaily)<TLdaily && candlesizeTL2daily>=3 && upshadowzdaily>=Bodyzdaily && iHigh(NULL,PERIOD_D1,zdaily)>(TLdaily+(MinLimitdaily)))
                 {
                  TL2daily=iHigh(NULL,PERIOD_D1,zdaily);
                  if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                  ObjectCreate("ML TL2 Candid W1-"+zdaily,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,zdaily),iOpen(NULL,PERIOD_D1,zdaily));
                  ObjectSet("ML TL2 Candid W1-"+zdaily,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL2 Candid W1-"+zdaily,OBJPROP_COLOR,Blue);
                  ObjectSet("ML TL2 Candid W1-"+zdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
                 }

               if(iClose(NULL,PERIOD_D1,zdaily)<TLdaily && candlesizeTL2daily<3 && upshadowzdaily>=(2*Bodyzdaily) && iHigh(NULL,PERIOD_D1,zdaily)>(TLdaily+(MinLimitdaily)))
                 {
                  TL2daily=iHigh(NULL,PERIOD_D1,zdaily);
                  if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                  ObjectCreate("ML TL2 Candid W2-"+zdaily,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,zdaily),iOpen(NULL,PERIOD_D1,zdaily));
                  ObjectSet("ML TL2 Candid W2-"+zdaily,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL2 Candid W2-"+zdaily,OBJPROP_COLOR,Blue);
                  ObjectSet("ML TL2 Candid W2-"+zdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
                 }

               if(iClose(NULL,PERIOD_D1,zdaily)<TLdaily && candlesizeTL2daily>=3 && iHigh(NULL,PERIOD_D1,zdaily)>(TLdaily+(MinLimitdaily)) && (iClose(NULL,PERIOD_D1,zdaily)<iOpen(NULL,PERIOD_D1,zdaily)))
                 {
                  TL2daily=iHigh(NULL,PERIOD_D1,zdaily);
                  if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                  ObjectCreate("ML TL2 Candid W3-"+zdaily,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,zdaily),iOpen(NULL,PERIOD_D1,zdaily));
                  ObjectSet("ML TL2 Candid W3-"+zdaily,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL2 Candid W3-"+zdaily,OBJPROP_COLOR,Blue);
                  ObjectSet("ML TL2 Candid W3-"+zdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);

                 }

               if(zdaily>q && iClose(NULL,PERIOD_D1,zdaily)>TLdaily && candlesizeTL2daily>=3 && iHigh(NULL,PERIOD_D1,zdaily)>(TLdaily+(MinLimitdaily)) && iLow(NULL,PERIOD_D1,(zdaily-1))<(iClose(NULL,PERIOD_D1,zdaily)-(0.45*(iClose(NULL,PERIOD_D1,zdaily)-iOpen(NULL,PERIOD_D1,zdaily)))))
                 {
                  TL2daily=MathMax(iHigh(NULL,PERIOD_D1,zdaily),iHigh(NULL,PERIOD_D1,(zdaily-1)));
                  if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                  ObjectCreate("ML TL2 Candid W4-"+zdaily,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,zdaily),iOpen(NULL,PERIOD_D1,zdaily));
                  ObjectSet("ML TL2 Candid W4-"+zdaily,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML TL2 Candid W4-"+zdaily,OBJPROP_COLOR,Blue);
                  ObjectSet("ML TL2 Candid W4-"+zdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);

                 }

              }

            if(((iLow(NULL,PERIOD_D1,zdaily)<LLdaily && iOpen(NULL,PERIOD_D1,zdaily)>LLdaily)))
              {

               if(iClose(NULL,PERIOD_D1,zdaily)>iOpen(NULL,PERIOD_D1,zdaily))
                 {
                  downshadowzdaily=MathAbs((iLow(NULL,PERIOD_D1,zdaily)-iOpen(NULL,PERIOD_D1,zdaily)+(1*Point))/Point);
                 }
               if(iClose(NULL,PERIOD_D1,zdaily)<iOpen(NULL,PERIOD_D1,zdaily))
                 {
                  downshadowzdaily=MathAbs((iLow(NULL,PERIOD_D1,zdaily)-iClose(NULL,PERIOD_D1,zdaily)+(1*Point))/Point);
                 }

               Bodyzdaily=MathAbs(iClose(NULL,PERIOD_D1,zdaily)-iOpen(NULL,PERIOD_D1,zdaily))/Point;
               int nLL2daily=zdaily;
               int MaxNLL2daily=zdaily;
               double MaxBodyLL2daily=zdaily;
               while(nLL2daily<(nOfCandleWdaily+zdaily))
                 {
                  double BodyLL2daily=((iOpen(NULL,PERIOD_D1,nLL2daily)-iClose(NULL,PERIOD_D1,nLL2daily))/Point);
                  double dyLL2daily=MathAbs(BodyLL2daily);
                  if(dyLL2daily>MaxBodyLL2daily)
                    {
                     MaxBodyLL2daily=dyLL2daily;
                     MaxNLL2daily=nLL2daily;
                    }
                  nLL2daily++;
                 }

               int n2LL2daily=zdaily;
               int MaxN2LL2daily=zdaily;
               double MaxBody2LL2daily=zdaily;
               while(n2LL2daily<(nOfCandleWdaily+zdaily))
                 {
                  double Body2LL2daily=((iOpen(NULL,PERIOD_D1,n2LL2daily)-iClose(NULL,PERIOD_D1,n2LL2daily))/Point);
                  double dy2LL2daily=MathAbs(Body2LL2daily);
                  if(dy2LL2daily<MaxBodyLL2daily && dy2LL2daily>MaxBody2LL2daily)
                    {
                     MaxBody2LL2daily=dy2LL2daily;
                     MaxN2LL2daily=n2LL2daily;
                    }
                  n2LL2daily++;
                 }

               double darsadLL2daily=(Bodyzdaily/((MaxBodyLL2daily+MaxBody2LL2daily)/2))*100;

               double candlesizeLL2daily;
               if(darsadLL2daily>=61)
                  candlesizeLL2daily=4;
               if(darsadLL2daily<61 && darsadLL2daily>=41)
                  candlesizeLL2daily=3;
               if(darsadLL2daily<41 && darsadLL2daily>5)
                  candlesizeLL2daily=2;
               if(darsadLL2daily<=5)
                  candlesizeLL2daily=1;

               if(iClose(NULL,PERIOD_D1,zdaily)>LLdaily && candlesizeLL2daily>=3 && downshadowzdaily>=Bodyzdaily && iLow(NULL,PERIOD_D1,zdaily)<(LLdaily-(MinLimitdaily)))
                 {
                  LL2daily=iLow(NULL,PERIOD_D1,zdaily);

                  if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                  ObjectCreate("ML LL2 Candid W1-"+zdaily,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,zdaily),iOpen(NULL,PERIOD_D1,zdaily));
                  ObjectSet("ML LL2 Candid W1-"+zdaily,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL2 Candid W1-"+zdaily,OBJPROP_COLOR,Red);
                  ObjectSet("ML LL2 Candid W1-"+zdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);

                 }

               if(iClose(NULL,PERIOD_D1,zdaily)>LLdaily && candlesizeLL2daily<3 && downshadowzdaily>=(2*Bodyzdaily) && iLow(NULL,PERIOD_D1,zdaily)<(LLdaily-(MinLimitdaily)))
                 {

                  LL2daily=iLow(NULL,PERIOD_D1,zdaily);

                  if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                  ObjectCreate("ML LL2 Candid W2-"+zdaily,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,zdaily),iOpen(NULL,PERIOD_D1,zdaily));
                  ObjectSet("ML LL2 Candid W2-"+zdaily,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL2 Candid W2-"+zdaily,OBJPROP_COLOR,Red);
                  ObjectSet("ML LL2 Candid W2-"+zdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);

                 }

               if(iClose(NULL,PERIOD_D1,zdaily)>LLdaily && candlesizeLL2daily>=3 && iLow(NULL,PERIOD_D1,zdaily)<(LLdaily-(MinLimitdaily)) && (iClose(NULL,PERIOD_D1,zdaily)>iOpen(NULL,PERIOD_D1,zdaily)))
                 {
                  LL2daily=iLow(NULL,PERIOD_D1,zdaily);

                  if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                  ObjectCreate("ML LL2 Candid W3-"+zdaily,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,zdaily),iOpen(NULL,PERIOD_D1,zdaily));
                  ObjectSet("ML LL2 Candid W3-"+zdaily,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL2 Candid W3-"+zdaily,OBJPROP_COLOR,Red);
                  ObjectSet("ML LL2 Candid W3-"+zdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);

                 }

               if(zdaily>q && iClose(NULL,PERIOD_D1,zdaily)<LLdaily && candlesizeLL2daily>=3 && iLow(NULL,PERIOD_D1,zdaily)<(LLdaily-(MinLimitdaily)) && iHigh(NULL,PERIOD_D1,(zdaily-1))>(iClose(NULL,PERIOD_D1,zdaily)+(0.45*(iOpen(NULL,PERIOD_D1,zdaily)-iClose(NULL,PERIOD_D1,zdaily)))))
                 {
                  LL2daily=MathMin(iLow(NULL,PERIOD_D1,zdaily),iLow(NULL,PERIOD_D1,(zdaily-1)));
                  if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                  ObjectCreate("ML LL2 Candid W4"+zdaily,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,zdaily),iOpen(NULL,PERIOD_D1,zdaily));
                  ObjectSet("ML LL2 Candid W4"+zdaily,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet("ML LL2 Candid W4"+zdaily,OBJPROP_COLOR,Red);
                  ObjectSet("ML LL2 Candid W4"+zdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);

                 }

              }
           }
         zdaily++;
        }

      if(minTL2daily==TLdaily+((TLdaily-LLdaily)*2))
        {
         int shoroTdaily=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_D1,q));
         ObjectCreate("ML ShoroTD1-"+shoroTdaily,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,shoroTdaily-1),0);
         ObjectSet("ML ShoroTD1-"+shoroTdaily,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML ShoroTD1-"+shoroTdaily,OBJPROP_COLOR,Purple);
         ObjectSet("ML ShoroTD1-"+shoroTdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);

         int z2daily=shoroTdaily;
         int nz2daily=shoroTdaily;
         int count2daily=0;
         bool mohiti2daily;
         double Bodyz2daily;
         double upshadowz2daily;

         while(z2daily<(iBars(NULL,PERIOD_H4)-1) && count2daily<=MaxTPSLCalcdaily && count2daily<=iBars(NULL,PERIOD_H4)-2-z2daily)
           {
              {
               if(iHigh(NULL,PERIOD_H4,z2daily)>LLdaily && iLow(NULL,PERIOD_H4,z2daily)<TLdaily)
                 {
                  mohiti2daily=1;
                  count2daily++;
                  ObjectCreate("ML MohitiTD1T-"+z2daily,OBJ_ARROW_CHECK,0,iTime(NULL,PERIOD_H4,z2daily),iOpen(NULL,PERIOD_H4,z2daily));
                  ObjectSet("ML MohitiTD1T-"+z2daily,OBJPROP_COLOR,Blue);
                  ObjectSet("ML MohitiTD1T-"+z2daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                 }
               else mohiti2daily=0;
              }

            if(mohiti2daily==1)
              {
               if((iHigh(NULL,PERIOD_H4,z2daily)>TLdaily && iOpen(NULL,PERIOD_H4,z2daily)<TLdaily))
                 {
                  if(iClose(NULL,PERIOD_H4,z2daily)>iOpen(NULL,PERIOD_H4,z2daily))
                    {
                     upshadowz2daily=MathAbs((iHigh(NULL,PERIOD_H4,z2daily)-iClose(NULL,PERIOD_H4,z2daily)+(1*Point))/Point);
                    }
                  if(iClose(NULL,PERIOD_H4,z2daily)<iOpen(NULL,PERIOD_H4,z2daily))
                    {
                     upshadowz2daily=MathAbs((iHigh(NULL,PERIOD_H4,z2daily)-iOpen(NULL,PERIOD_H4,z2daily)+(1*Point))/Point);
                    }

                  Bodyz2daily=MathAbs(iClose(NULL,PERIOD_H4,z2daily)-iOpen(NULL,PERIOD_H4,z2daily))/Point;
                  int nTL22daily=z2daily;
                  int MaxNTL22daily=z2daily;
                  double MaxBodyTL22daily=z2daily;
                  while(nTL22daily<(nOfCandleWdaily+z2daily))
                    {
                     double BodyTL22daily=((iOpen(NULL,PERIOD_H4,nTL22daily)-iClose(NULL,PERIOD_H4,nTL22daily))/Point);
                     double dyTL22daily=MathAbs(BodyTL22daily);
                     if(dyTL22daily>MaxBodyTL22daily)
                       {
                        MaxBodyTL22daily=dyTL22daily;
                        MaxNTL22daily=nTL22daily;
                       }
                     nTL22daily++;
                    }

                  int n2TL22daily=z2daily;
                  int MaxN2TL22daily=z2daily;
                  double MaxBody2TL22daily=z2daily;
                  while(n2TL22daily<(nOfCandleWdaily+z2daily))
                    {
                     double Body2TL22daily=((iOpen(NULL,PERIOD_H4,n2TL22daily)-iClose(NULL,PERIOD_H4,n2TL22daily))/Point);
                     double dy2TL22daily=MathAbs(Body2TL22daily);
                     if(dy2TL22daily<MaxBodyTL22daily && dy2TL22daily>MaxBody2TL22daily)
                       {
                        MaxBody2TL22daily=dy2TL22daily;
                        MaxN2TL22daily=n2TL22daily;
                       }
                     n2TL22daily++;
                    }

                  double darsadTL22daily=(Bodyz2daily/((MaxBodyTL22daily+MaxBody2TL22daily)/2))*100;

                  double candlesizeTL22daily;
                  if(darsadTL22daily>=61)
                     candlesizeTL22daily=4;
                  if(darsadTL22daily<61 && darsadTL22daily>=41)
                     candlesizeTL22daily=3;
                  if(darsadTL22daily<41 && darsadTL22daily>5)
                     candlesizeTL22daily=2;
                  if(darsadTL22daily<=5)
                     candlesizeTL22daily=1;

                  if(iClose(NULL,PERIOD_H4,z2daily)<TLdaily && candlesizeTL22daily>=3 && upshadowz2daily>=Bodyz2daily && iHigh(NULL,PERIOD_H4,z2daily)>(TLdaily+(MinLimitdaily)))
                    {
                     TL2daily=iHigh(NULL,PERIOD_H4,z2daily);
                     if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                     ObjectCreate("ML TL2 Candid D11-"+z2daily,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,z2daily),iOpen(NULL,PERIOD_H4,z2daily));
                     ObjectSet("ML TL2 Candid D11-"+z2daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML TL2 Candid D11-"+z2daily,OBJPROP_COLOR,Blue);
                     ObjectSet("ML TL2 Candid D11-"+z2daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }

                  if(iClose(NULL,PERIOD_H4,z2daily)<TLdaily && candlesizeTL22daily<3 && upshadowz2daily>=(2*Bodyz2daily) && iHigh(NULL,PERIOD_H4,z2daily)>(TLdaily+(MinLimitdaily)))
                    {
                     TL2daily=iHigh(NULL,PERIOD_H4,z2daily);
                     if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                     ObjectCreate("ML TL2 Candid D12-"+z2daily,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,z2daily),iOpen(NULL,PERIOD_H4,z2daily));
                     ObjectSet("ML TL2 Candid D12-"+z2daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML TL2 Candid D12-"+z2daily,OBJPROP_COLOR,Blue);
                     ObjectSet("ML TL2 Candid D12-"+z2daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                  if(iClose(NULL,PERIOD_H4,z2daily)<TLdaily && candlesizeTL22daily>=3 && iHigh(NULL,PERIOD_H4,z2daily)>(TLdaily+(MinLimitdaily)) && (iClose(NULL,PERIOD_H4,z2daily)<iOpen(NULL,PERIOD_H4,z2daily)))
                    {
                     TL2daily=iHigh(NULL,PERIOD_H4,z2daily);
                     if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                     ObjectCreate("TL2 Candid D13-"+z2daily,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,z2daily),iOpen(NULL,PERIOD_H4,z2daily));
                     ObjectSet("TL2 Candid D13-"+z2daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("TL2 Candid D13-"+z2daily,OBJPROP_COLOR,Blue);
                     ObjectSet("TL2 Candid D13-"+z2daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                  if(z2daily>shoroTdaily && iClose(NULL,PERIOD_H4,z2daily)>TLdaily && candlesizeTL22daily>=3 && iHigh(NULL,PERIOD_H4,z2daily)>(TLdaily+(MinLimitdaily)) && iLow(NULL,PERIOD_H4,(z2daily-1))<(iClose(NULL,PERIOD_H4,z2daily)-(0.45*(iClose(NULL,PERIOD_H4,z2daily)-iOpen(NULL,PERIOD_H4,z2daily)))))
                    {
                     TL2daily=MathMax(iHigh(NULL,PERIOD_H4,z2daily),iHigh(NULL,PERIOD_H4,(z2daily-1)));
                     if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                     ObjectCreate("ML TL2 Candid D14-"+z2daily,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,z2daily),iOpen(NULL,PERIOD_H4,z2daily));
                     ObjectSet("ML TL2 Candid D14-"+z2daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML TL2 Candid D14-"+z2daily,OBJPROP_COLOR,Blue);
                     ObjectSet("ML TL2 Candid D14-"+z2daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                 }

              }
            z2daily++;
           }

        }
      if(minTL2daily==TLdaily+((TLdaily-LLdaily)*2))
        {
         int shoroT2daily=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q));
         ObjectCreate("ML shoroTH4T-"+shoroT2daily,OBJ_VLINE,0,iTime(NULL,PERIOD_H1,shoroT2daily-1),iLow(NULL,PERIOD_H1,shoroT2daily-1));
         ObjectSet("ML shoroTH4T-"+shoroT2daily,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroTH4T-"+shoroT2daily,OBJPROP_COLOR,Red);
         ObjectSet("ML shoroTH4T-"+shoroT2daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);

         int z4daily=shoroT2daily;
         int nz4daily=shoroT2daily;
         int count4daily=0;
         bool mohiti4daily;
         double Bodyz4daily;
         double upshadowz4daily;

         while(z4daily<(iBars(NULL,PERIOD_H1)-1) && count4daily<=MaxTPSLCalcdaily && count4daily<=iBars(NULL,PERIOD_H1)-2-z4daily)
           {
              {
               if(iHigh(NULL,PERIOD_H1,z4daily)>LLdaily && iLow(NULL,PERIOD_H1,z4daily)<TLdaily)
                 {
                  mohiti4daily=1;
                  count4daily++;
                  ObjectCreate("ML MohitiTH4T-"+z4daily,OBJ_ARROW_CHECK,0,iTime(NULL,PERIOD_H1,z4daily),iOpen(NULL,PERIOD_H1,z4daily));
                  ObjectSet("ML MohitiTH4T-"+z4daily,OBJPROP_COLOR,Blue);
                  ObjectSet("ML MohitiTH4T-"+z4daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
                 }
               else mohiti4daily=0;
              }

            if(mohiti4daily==1)
              {
               if((iHigh(NULL,PERIOD_H1,z4daily)>TLdaily && iOpen(NULL,PERIOD_H1,z4daily)<TLdaily))
                 {
                  if(iClose(NULL,PERIOD_H1,z4daily)>iOpen(NULL,PERIOD_H1,z4daily))
                    {
                     upshadowz4daily=MathAbs((iHigh(NULL,PERIOD_H1,z4daily)-iClose(NULL,PERIOD_H1,z4daily)+(1*Point))/Point);
                    }
                  if(iClose(NULL,PERIOD_H1,z4daily)<iOpen(NULL,PERIOD_H1,z4daily))
                    {
                     upshadowz4daily=MathAbs((iHigh(NULL,PERIOD_H1,z4daily)-iOpen(NULL,PERIOD_H1,z4daily)+(1*Point))/Point);
                    }

                  Bodyz4daily=MathAbs(iClose(NULL,PERIOD_H1,z4daily)-iOpen(NULL,PERIOD_H1,z4daily))/Point;
                  int nTL24daily=z4daily;
                  int MaxNTL24daily=z4daily;
                  double MaxBodyTL24daily=z4daily;
                  while(nTL24daily<(nOfCandleWdaily+z4daily))
                    {
                     double BodyTL24daily=((iOpen(NULL,PERIOD_H1,nTL24daily)-iClose(NULL,PERIOD_H1,nTL24daily))/Point);
                     double dyTL24daily=MathAbs(BodyTL24daily);
                     if(dyTL24daily>MaxBodyTL24daily)
                       {
                        MaxBodyTL24daily=dyTL24daily;
                        MaxNTL24daily=nTL24daily;
                       }
                     nTL24daily++;
                    }

                  int n2TL24daily=z4daily;
                  int MaxN2TL24daily=z4daily;
                  double MaxBody2TL24daily=z4daily;
                  while(n2TL24daily<(nOfCandleWdaily+z4daily))
                    {
                     double Body2TL24daily=((iOpen(NULL,PERIOD_H1,n2TL24daily)-iClose(NULL,PERIOD_H1,n2TL24daily))/Point);
                     double dy2TL24daily=MathAbs(Body2TL24daily);
                     if(dy2TL24daily<MaxBodyTL24daily && dy2TL24daily>MaxBody2TL24daily)
                       {
                        MaxBody2TL24daily=dy2TL24daily;
                        MaxN2TL24daily=n2TL24daily;
                       }
                     n2TL24daily++;
                    }

                  double darsadTL24daily=(Bodyz4daily/((MaxBodyTL24daily+MaxBody2TL24daily)/2))*100;

                  double candlesizeTL24daily;
                  if(darsadTL24daily>=61)
                     candlesizeTL24daily=4;
                  if(darsadTL24daily<61 && darsadTL24daily>=41)
                     candlesizeTL24daily=3;
                  if(darsadTL24daily<41 && darsadTL24daily>5)
                     candlesizeTL24daily=2;
                  if(darsadTL24daily<=5)
                     candlesizeTL24daily=1;

                  if(iClose(NULL,PERIOD_H1,z4daily)<TLdaily && candlesizeTL24daily>=3 && upshadowz4daily>=Bodyz4daily && iHigh(NULL,PERIOD_H1,z4daily)>(TLdaily+(MinLimitdaily)))
                    {
                     TL2daily=iHigh(NULL,PERIOD_H1,z4daily);
                     if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                     ObjectCreate("ML TL2 Candid H41-"+z4daily,OBJ_VLINE,0,iTime(NULL,PERIOD_H1,z4daily),iOpen(NULL,PERIOD_H1,z4daily));
                     ObjectSet("ML TL2 Candid H41-"+z4daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML TL2 Candid H41-"+z4daily,OBJPROP_COLOR,Blue);
                     ObjectSet("ML TL2 Candid H41-"+z4daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }

                  if(iClose(NULL,PERIOD_H1,z4daily)<TLdaily && candlesizeTL24daily<3 && upshadowz4daily>=(2*Bodyz4daily) && iHigh(NULL,PERIOD_H1,z4daily)>(TLdaily+(MinLimitdaily)))
                    {
                     TL2daily=iHigh(NULL,PERIOD_H1,z4daily);
                     if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                     ObjectCreate("ML TL2 Candid H42-"+z4daily,OBJ_VLINE,0,iTime(NULL,PERIOD_H1,z4daily),iOpen(NULL,PERIOD_H1,z4daily));
                     ObjectSet("ML TL2 Candid H42-"+z4daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML TL2 Candid H42-"+z4daily,OBJPROP_COLOR,Blue);
                     ObjectSet("ML TL2 Candid H42-"+z4daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }

                  if(iClose(NULL,PERIOD_H1,z4daily)<TLdaily && candlesizeTL24daily>=3 && iHigh(NULL,PERIOD_H1,z4daily)>(TLdaily+(MinLimitdaily)) && (iClose(NULL,PERIOD_H1,z4daily)<iOpen(NULL,PERIOD_H1,z4daily)))
                    {
                     TL2daily=iHigh(NULL,PERIOD_H1,z4daily);
                     if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                     ObjectCreate("ML TL2 Candid H43-"+z4daily,OBJ_VLINE,0,iTime(NULL,PERIOD_H1,z4daily),iOpen(NULL,PERIOD_H1,z4daily));
                     ObjectSet("ML TL2 Candid H43-"+z4daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML TL2 Candid H43-"+z4daily,OBJPROP_COLOR,Blue);
                     ObjectSet("ML TL2 Candid H43-"+z4daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }

                  if(z4daily>shoroT2daily && iClose(NULL,PERIOD_H1,z4daily)>TLdaily && candlesizeTL24daily>=3 && iHigh(NULL,PERIOD_H1,z4daily)>(TLdaily+(MinLimitdaily)) && iLow(NULL,PERIOD_H1,(z4daily-1))<(iClose(NULL,PERIOD_H1,z4daily)-(0.45*(iClose(NULL,PERIOD_H1,z4daily)-iOpen(NULL,PERIOD_H1,z4daily)))))
                    {
                     TL2daily=MathMax(iHigh(NULL,PERIOD_H1,z4daily),iHigh(NULL,PERIOD_H1,(z4daily-1)));
                     if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                     ObjectCreate("ML TL2 Candid H44-"+z4daily,OBJ_VLINE,0,iTime(NULL,PERIOD_H1,z4daily),iOpen(NULL,PERIOD_H1,z4daily));
                     ObjectSet("ML ML TL2 Candid H44-"+z4daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML TL2 Candid H44-"+z4daily,OBJPROP_COLOR,Blue);
                     ObjectSet("ML TL2 Candid H44-"+z4daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }

                 }

              }
            z4daily++;
           }

        }

      if(minLL2daily==LLdaily-((TLdaily-LLdaily)*2))
        {
         int shoroLdaily=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_D1,q));
         ObjectCreate("ML shoroLD1-"+shoroLdaily,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,shoroLdaily-1),iLow(NULL,PERIOD_H4,shoroLdaily-1));
         ObjectSet("ML shoroLD1-"+shoroLdaily,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroLD1-"+shoroLdaily,OBJPROP_COLOR,Purple);
         ObjectSet("ML shoroLD1-"+shoroLdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);

         int z3daily=shoroLdaily;
         int nz3daily=shoroLdaily;
         int count3daily=0;
         bool mohiti3daily;
         double Bodyz3daily;
         double downshadowz3daily;

         while(z3daily<(iBars(NULL,PERIOD_H4)-1) && count3daily<=MaxTPSLCalcdaily && count3daily<=iBars(NULL,PERIOD_H4)-2-z3daily)
           {
              {
               if(iHigh(NULL,PERIOD_H4,z3daily)>LLdaily && iLow(NULL,PERIOD_H4,z3daily)<TLdaily)
                 {
                  mohiti3daily=1;
                  count3daily++;
                  ObjectCreate("ML MohitiTD1L-"+z3daily,OBJ_ARROW_CHECK,0,iTime(NULL,PERIOD_H4,z3daily),iOpen(NULL,PERIOD_H4,z3daily));
                  ObjectSet("ML MohitiTD1L-"+z3daily,OBJPROP_COLOR,Blue);
                  ObjectSet("ML MohitiTD1L-"+z3daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                 }
               else mohiti3daily=0;
              }

            if(mohiti3daily==1)
              {

               if(((iLow(NULL,PERIOD_H4,z3daily)<LLdaily && iOpen(NULL,PERIOD_H4,z3daily)>LLdaily)))
                 {

                  if(iClose(NULL,PERIOD_H4,z3daily)>iOpen(NULL,PERIOD_H4,z3daily))
                    {
                     downshadowz3daily=MathAbs((iLow(NULL,PERIOD_H4,z3daily)-iOpen(NULL,PERIOD_H4,z3daily)+(1*Point))/Point);
                    }
                  if(iClose(NULL,PERIOD_H4,z3daily)<iOpen(NULL,PERIOD_H4,z3daily))
                    {
                     downshadowz3daily=MathAbs((iLow(NULL,PERIOD_H4,z3daily)-iClose(NULL,PERIOD_H4,z3daily)+(1*Point))/Point);
                    }

                  Bodyz3daily=MathAbs(iClose(NULL,PERIOD_H4,z3daily)-iOpen(NULL,PERIOD_H4,z3daily))/Point;
                  int nLL23daily=z3daily;
                  int MaxNLL23daily=z3daily;
                  double MaxBodyLL23daily=z3daily;
                  while(nLL23daily<(nOfCandleWdaily+z3daily))
                    {
                     double BodyLL23daily=((iOpen(NULL,PERIOD_H4,nLL23daily)-iClose(NULL,PERIOD_H4,nLL23daily))/Point);
                     double dyLL23daily=MathAbs(BodyLL23daily);
                     if(dyLL23daily>MaxBodyLL23daily)
                       {
                        MaxBodyLL23daily=dyLL23daily;
                        MaxNLL23daily=nLL23daily;
                       }
                     nLL23daily++;
                    }

                  int n2LL23daily=z3daily;
                  int MaxN2LL23daily=z3daily;
                  double MaxBody2LL23daily=z3daily;
                  while(n2LL23daily<(nOfCandleWdaily+z3daily))
                    {
                     double Body2LL23daily=((iOpen(NULL,PERIOD_H4,n2LL23daily)-iClose(NULL,PERIOD_H4,n2LL23daily))/Point);
                     double dy2LL23daily=MathAbs(Body2LL23daily);
                     if(dy2LL23daily<MaxBodyLL23daily && dy2LL23daily>MaxBody2LL23daily)
                       {
                        MaxBody2LL23daily=dy2LL23daily;
                        MaxN2LL23daily=n2LL23daily;
                       }
                     n2LL23daily++;
                    }

                  double darsadLL23daily=(Bodyz3daily/((MaxBodyLL23daily+MaxBody2LL23daily)/2))*100;

                  double candlesizeLL23daily;
                  if(darsadLL23daily>=61)
                     candlesizeLL23daily=4;
                  if(darsadLL23daily<61 && darsadLL23daily>=41)
                     candlesizeLL23daily=3;
                  if(darsadLL23daily<41 && darsadLL23daily>5)
                     candlesizeLL23daily=2;
                  if(darsadLL23daily<=5)
                     candlesizeLL23daily=1;

                  if(iClose(NULL,PERIOD_H4,z3daily)>LLdaily && candlesizeLL23daily>=3 && downshadowz3daily>=Bodyz3daily && iLow(NULL,PERIOD_H4,z3daily)<(LLdaily-(MinLimitdaily)))
                    {
                     LL2daily=iLow(NULL,PERIOD_H4,z3daily);
                     if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                     ObjectCreate("ML LL2 Candid LD11-"+z3daily,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,z3daily),iOpen(NULL,PERIOD_H4,z3daily));
                     ObjectSet("ML LL2 Candid LD11-"+z3daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid LD11-"+z3daily,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid LD11-"+z3daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                  if(iClose(NULL,PERIOD_H4,z3daily)>LLdaily && candlesizeLL23daily<3 && downshadowz3daily>=(2*Bodyz3daily) && iLow(NULL,PERIOD_H4,z3daily)<(LLdaily-(MinLimitdaily)))
                    {
                     LL2daily=iLow(NULL,PERIOD_H4,z3daily);
                     if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                     ObjectCreate("ML LL2 Candid LD12-"+z3daily,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,z3daily),iOpen(NULL,PERIOD_H4,z3daily));
                     ObjectSet("ML LL2 Candid LD12-"+z3daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid LD12-"+z3daily,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid LD12-"+z3daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                  if(iClose(NULL,PERIOD_H4,z3daily)>LLdaily && candlesizeLL23daily>=3 && iLow(NULL,PERIOD_H4,z3daily)<(LLdaily-(MinLimitdaily)) && (iClose(NULL,PERIOD_H4,z3daily)>iOpen(NULL,PERIOD_H4,z3daily)))
                    {
                     LL2daily=iLow(NULL,PERIOD_H4,z3daily);
                     if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                     ObjectCreate("ML LL2 Candid LD13-"+z3daily,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,z3daily),iOpen(NULL,PERIOD_H4,z3daily));
                     ObjectSet("ML LL2 Candid LD13-"+z3daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid LD13-"+z3daily,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid LD13-"+z3daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                  if(z3daily>shoroLdaily && iClose(NULL,PERIOD_H4,z3daily)<LLdaily && candlesizeLL23daily>=3 && iLow(NULL,PERIOD_H4,z3daily)<(LLdaily-(MinLimitdaily)) && iHigh(NULL,PERIOD_H4,(z3daily-1))>(iClose(NULL,PERIOD_H4,z3daily)+(0.45*(iOpen(NULL,PERIOD_H4,z3daily)-iClose(NULL,PERIOD_H4,z3daily)))))
                    {
                     LL2daily=MathMin(iLow(NULL,PERIOD_H4,z3daily),iLow(NULL,PERIOD_H4,(z3daily-1)));
                     if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                     ObjectCreate("ML LL2 Candid LD14-"+z3daily,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,z3daily),iOpen(NULL,PERIOD_H4,z3daily));
                     ObjectSet("ML LL2 Candid LD14-"+z3daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid LD14-"+z3daily,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid LD14-"+z3daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                    }

                 }
              }
            z3daily++;
           }

        }

      if(minLL2daily==LLdaily-((TLdaily-LLdaily)*2))
        {
         int shoroL2daily=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q));
         ObjectCreate("shoroLH4L-"+shoroL2daily,OBJ_VLINE,0,iTime(NULL,PERIOD_H1,shoroL2daily-1),iLow(NULL,PERIOD_H1,shoroL2daily-1));
         ObjectSet("shoroLH4L-"+shoroL2daily,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("shoroLH4L-"+shoroL2daily,OBJPROP_COLOR,Purple);
         ObjectSet("shoroLH4L-"+shoroL2daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);

         int z5daily=shoroL2daily;
         int nz5daily=shoroL2daily;
         int count5daily=0;
         bool mohiti5daily;
         double Bodyz5daily;
         double downshadowz5daily;

         while(z5daily<(iBars(NULL,PERIOD_H1)-1) && count5daily<=MaxTPSLCalcdaily && count5daily<=iBars(NULL,PERIOD_H1)-2-z5daily)
           {
              {
               if(iHigh(NULL,PERIOD_H1,z5daily)>LLdaily && iLow(NULL,PERIOD_H1,z5daily)<TLdaily)
                 {
                  mohiti5daily=1;
                  count5daily++;
                  ObjectCreate("MohitiTH4-"+z5daily,OBJ_ARROW_CHECK,0,iTime(NULL,PERIOD_H1,z5daily),iOpen(NULL,PERIOD_H1,z5daily));
                  ObjectSet("MohitiTH4-"+z5daily,OBJPROP_COLOR,Blue);
                  ObjectSet("MohitiTH4-"+z5daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
                 }
               else mohiti5daily=0;
              }

            if(mohiti5daily==1)
              {

               if(((iLow(NULL,PERIOD_H1,z5daily)<LLdaily && iOpen(NULL,PERIOD_H1,z5daily)>LLdaily)))
                 {

                  if(iClose(NULL,PERIOD_H1,z5daily)>iOpen(NULL,PERIOD_H1,z5daily))
                    {
                     downshadowz5daily=MathAbs((iLow(NULL,PERIOD_H1,z5daily)-iOpen(NULL,PERIOD_H1,z5daily)+(1*Point))/Point);
                    }
                  if(iClose(NULL,PERIOD_H1,z5daily)<iOpen(NULL,PERIOD_H1,z5daily))
                    {
                     downshadowz5daily=MathAbs((iLow(NULL,PERIOD_H1,z5daily)-iClose(NULL,PERIOD_H1,z5daily)+(1*Point))/Point);
                    }

                  Bodyz5daily=MathAbs(iClose(NULL,PERIOD_H1,z5daily)-iOpen(NULL,PERIOD_H1,z5daily))/Point;
                  int nLL25daily=z5daily;
                  int MaxNLL25daily=z5daily;
                  double MaxBodyLL25daily=z5daily;
                  while(nLL25daily<(nOfCandleWdaily+z5daily))
                    {
                     double BodyLL25daily=((iOpen(NULL,PERIOD_H1,nLL25daily)-iClose(NULL,PERIOD_H1,nLL25daily))/Point);
                     double dyLL25daily=MathAbs(BodyLL25daily);
                     if(dyLL25daily>MaxBodyLL25daily)
                       {
                        MaxBodyLL25daily=dyLL25daily;
                        MaxNLL25daily=nLL25daily;
                       }
                     nLL25daily++;
                    }

                  int n2LL25daily=z5daily;
                  int MaxN2LL25daily=z5daily;
                  double MaxBody2LL25daily=z5daily;
                  while(n2LL25daily<(nOfCandleWdaily+z5daily))
                    {
                     double Body2LL25daily=((iOpen(NULL,PERIOD_H1,n2LL25daily)-iClose(NULL,PERIOD_H1,n2LL25daily))/Point);
                     double dy2LL25daily=MathAbs(Body2LL25daily);
                     if(dy2LL25daily<MaxBodyLL25daily && dy2LL25daily>MaxBody2LL25daily)
                       {
                        MaxBody2LL25daily=dy2LL25daily;
                        MaxN2LL25daily=n2LL25daily;
                       }
                     n2LL25daily++;
                    }

                  double darsadLL25daily=(Bodyz5daily/((MaxBodyLL25daily+MaxBody2LL25daily)/2))*100;

                  double candlesizeLL25daily;
                  if(darsadLL25daily>=61)
                     candlesizeLL25daily=4;
                  if(darsadLL25daily<61 && darsadLL25daily>=41)
                     candlesizeLL25daily=3;
                  if(darsadLL25daily<41 && darsadLL25daily>5)
                     candlesizeLL25daily=2;
                  if(darsadLL25daily<=5)
                     candlesizeLL25daily=1;

                  if(iClose(NULL,PERIOD_H1,z5daily)>LLdaily && candlesizeLL25daily>=3 && downshadowz5daily>=Bodyz5daily && iLow(NULL,PERIOD_H1,z5daily)<(LLdaily-(MinLimitdaily)))
                    {
                     LL2daily=iLow(NULL,PERIOD_H1,z5daily);
                     if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                     ObjectCreate("ML LL2 Candid LH41-"+z5daily,OBJ_VLINE,0,iTime(NULL,PERIOD_H1,z5daily),iOpen(NULL,PERIOD_H1,z5daily));
                     ObjectSet("ML LL2 Candid LH41-"+z5daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid LH41-"+z5daily,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid LH41-"+z5daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }

                  if(iClose(NULL,PERIOD_H1,z5daily)>LLdaily && candlesizeLL25daily<3 && downshadowz5daily>=(2*Bodyz5daily) && iLow(NULL,PERIOD_H1,z5daily)<(LLdaily-(MinLimitdaily)))
                    {
                     LL2daily=iLow(NULL,PERIOD_H1,z5daily);
                     if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                     ObjectCreate("ML LL2 Candid LH42-"+z5daily,OBJ_VLINE,0,iTime(NULL,PERIOD_H1,z5daily),iOpen(NULL,PERIOD_H1,z5daily));
                     ObjectSet("ML LL2 Candid LH42-"+z5daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid LH42-"+z5daily,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid LH42-"+z5daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }

                  if(iClose(NULL,PERIOD_H1,z5daily)>LLdaily && candlesizeLL25daily>=3 && iLow(NULL,PERIOD_H1,z5daily)<(LLdaily-(MinLimitdaily)) && (iClose(NULL,PERIOD_H1,z5daily)>iOpen(NULL,PERIOD_H1,z5daily)))
                    {
                     LL2daily=iLow(NULL,PERIOD_H1,z5daily);
                     if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                     ObjectCreate("ML LL2 Candid LH43-"+z5daily,OBJ_VLINE,0,iTime(NULL,PERIOD_H1,z5daily),iOpen(NULL,PERIOD_H1,z5daily));
                     ObjectSet("ML LL2 Candid LH43-"+z5daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid LH43-"+z5daily,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid LH43-"+z5daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }

                  if(z5daily>shoroL2daily && iClose(NULL,PERIOD_H1,z5daily)<LLdaily && candlesizeLL25daily>=3 && iLow(NULL,PERIOD_H1,z5daily)<(LLdaily-(MinLimitdaily)) && iHigh(NULL,PERIOD_H1,(z5daily-1))>(iClose(NULL,PERIOD_H1,z5daily)+(0.45*(iOpen(NULL,PERIOD_H1,z5daily)-iClose(NULL,PERIOD_H1,z5daily)))))
                    {
                     LL2daily=MathMin(iLow(NULL,PERIOD_H1,z5daily),iLow(NULL,PERIOD_H1,(z5daily-1)));
                     if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                     ObjectCreate("ML LL2 Candid LH44-"+z5daily,OBJ_VLINE,0,iTime(NULL,PERIOD_H1,z5daily),iOpen(NULL,PERIOD_H1,z5daily));
                     ObjectSet("ML LL2 Candid LH44-"+z5daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet("ML LL2 Candid LH44-"+z5daily,OBJPROP_COLOR,Red);
                     ObjectSet("ML LL2 Candid LH44-"+z5daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                    }

                 }
              }
            z5daily++;
           }

        }
      int cntTdaily,cntLdaily;
      if(minTL2daily==TLdaily+((TLdaily-LLdaily)*2) && cntTdaily==0)
        {
         Alert(Symbol(),"حد دوم بالا یافت نشد");
         if(minLL2daily!=LLdaily-((TLdaily-LLdaily)*2))
           {
            minTL2daily=TLdaily+(LLdaily-minLL2daily);
           }
         cntTdaily=1;
        }
      if(minLL2daily==LLdaily-((TLdaily-LLdaily)*2) && cntLdaily==0)
        {
         Alert(Symbol(),"حد دوم پایین یافت نشد");
         if(minTL2daily!=TLdaily+((TLdaily-LLdaily)*2))
           {
            minLL2daily=LLdaily-(minTL2daily-TLdaily);
           }
         cntLdaily=1;
        }

      int zdaily_star=q+1;
      int nzdaily_star=q+1;
      double minTL2daily_star=TLdaily+(600*Point);
      double TL2daily_star;

      while(zdaily_star<iBars(NULL,PERIOD_D1)-1)
        {
         if(iHigh(NULL,PERIOD_D1,zdaily_star)>(TLdaily+(250*Point)) && iClose(NULL,PERIOD_D1,zdaily_star)<TLdaily && iOpen(NULL,PERIOD_D1,zdaily_star)>LLdaily && iOpen(NULL,PERIOD_D1,zdaily_star)<TLdaily)
           {
            TL2daily_star=iHigh(NULL,PERIOD_D1,zdaily_star);
            if(TL2daily_star<minTL2daily_star)minTL2daily_star=TL2daily_star;
           }
         zdaily_star++;
        }

      int ydaily_star=q+1;
      int nydaily_star=q+1;
      double minLL2daily_star=LLdaily-(600*Point);
      double LL2daily_star;
      while(ydaily_star<iBars(NULL,PERIOD_D1)-1)
        {
         if(iLow(NULL,PERIOD_D1,ydaily_star)<(LLdaily-(250*Point)) && iClose(NULL,PERIOD_D1,ydaily_star)>LLdaily && LLdaily<iOpen(NULL,PERIOD_D1,ydaily_star) && iOpen(NULL,PERIOD_D1,ydaily_star)<TLdaily)
           {
            LL2daily_star=iLow(NULL,PERIOD_D1,ydaily_star);
            if(LL2daily_star>minLL2daily_star)minLL2daily_star=LL2daily_star;
           }
         ydaily_star++;
        }

      ObjectCreate("ML starlineTdaily",OBJ_HLINE,0,Time[0],minTL2daily_star,0,0);
      ObjectSet("ML starlineTdaily",OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1|OBJ_PERIOD_H4|OBJ_PERIOD_D1);
      ObjectSet("ML starlineTdaily",OBJPROP_COLOR,Green);
      ObjectSet("ML starlineTdaily",OBJPROP_WIDTH,0);
      ObjectSet("ML starlineTdaily",OBJPROP_STYLE,STYLE_DOT);

      ObjectCreate("ML starlineLdaily",OBJ_HLINE,0,Time[0],minLL2daily_star,0,0);
      ObjectSet("ML starlineLdaily",OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1|OBJ_PERIOD_H4|OBJ_PERIOD_D1);
      ObjectSet("ML starlineLdaily",OBJPROP_COLOR,Green);
      ObjectSet("ML starlineLdaily",OBJPROP_WIDTH,0);
      ObjectSet("ML starlineLdaily",OBJPROP_STYLE,STYLE_DOT);

      ObjectCreate("ML Start-"+q,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,q-1),0);
      ObjectSet("ML Start-"+q,OBJPROP_STYLE,STYLE_SOLID);
      ObjectSet("ML Start-"+q,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
      ObjectSet("ML Start-"+q,OBJPROP_COLOR,Black);
      ObjectSet("ML Start-"+q,OBJPROP_WIDTH,1);

      ObjectCreate("ML End-"+q,OBJ_VLINE,0,iTime(NULL,PERIOD_D1,q-2),0);
      ObjectSet("ML End-"+q,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
      ObjectSet("ML End-"+q,OBJPROP_STYLE,STYLE_SOLID);
      ObjectSet("ML End-"+q,OBJPROP_COLOR,Black);
      ObjectSet("ML End-"+q,OBJPROP_WIDTH,1);

      ObjectCreate("ML TL",OBJ_HLINE,0,Time[0],TLdaily,0,0);
      ObjectSet("ML TL",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_M30);
      ObjectCreate("ML TL2",OBJ_HLINE,0,Time[0],minTL2daily,0,0);
      ObjectSet("ML TL2",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_M30);

      ObjectCreate("ML LL",OBJ_HLINE,0,Time[0],LLdaily,0,0);
      ObjectSet("ML LL",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_M30);
      ObjectCreate("ML LL2",OBJ_HLINE,0,Time[0],minLL2daily,0,0);
      ObjectSet("ML LL2",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_M30);

      ObjectSet("ML TL",OBJPROP_COLOR,Orange);
      ObjectSet("ML TL",OBJPROP_WIDTH,2);
      ObjectSet("ML LL",OBJPROP_COLOR,Orange);
      ObjectSet("ML LL",OBJPROP_WIDTH,2);
      ObjectSet("ML TL2",OBJPROP_COLOR,Purple);
      ObjectSet("ML TL2",OBJPROP_WIDTH,1);
      ObjectSet("ML LL2",OBJPROP_COLOR,Purple);
      ObjectSet("ML LL2",OBJPROP_WIDTH,1);

      Middleinlinedaily=LLdaily+((TLdaily-LLdaily)/2);

      ObjectCreate("ML First 0.33",OBJ_HLINE,0,Time[0],Middleinlinedaily,0,0);
      ObjectSet("ML First 0.33",OBJPROP_STYLE,STYLE_DASH);
      ObjectSet("ML First 0.33",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_M30);
      ObjectSet("ML First 0.33",OBJPROP_COLOR,Black);

      //------------------------
      //----------------------------------------/

      int zXdaily=q;
      int nzXdaily=q;
      int countXdaily=0;
      double BodyzXdaily;
      double upshadowzXdaily;
      double downshadowzXdaily;
      minTL4daily=minTL2daily+(TLdaily-LLdaily);

      while(zXdaily<(iBars(NULL,PERIOD_D1)-1) && countXdaily<=MaxTPSLCalcdaily && countXdaily<=iBars(NULL,PERIOD_D1)-2-zXdaily)
        {
         if(iClose(NULL,PERIOD_D1,zXdaily)>iOpen(NULL,PERIOD_D1,zXdaily))
           {
            upshadowzXdaily=MathAbs((iHigh(NULL,PERIOD_D1,zXdaily)-iClose(NULL,PERIOD_D1,zXdaily)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_D1,zXdaily)<iOpen(NULL,PERIOD_D1,zXdaily))
           {
            upshadowzXdaily=MathAbs((iHigh(NULL,PERIOD_D1,zXdaily)-iOpen(NULL,PERIOD_D1,zXdaily)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_D1,zXdaily)>iOpen(NULL,PERIOD_D1,zXdaily))
           {
            downshadowzXdaily=MathAbs((iLow(NULL,PERIOD_D1,zXdaily)-iOpen(NULL,PERIOD_D1,zXdaily)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_D1,zXdaily)<iOpen(NULL,PERIOD_D1,zXdaily))
           {
            downshadowzXdaily=MathAbs((iLow(NULL,PERIOD_D1,zXdaily)-iClose(NULL,PERIOD_D1,zXdaily)+(1*Point))/Point);
           }

         BodyzXdaily=MathAbs(iClose(NULL,PERIOD_D1,zXdaily)-iOpen(NULL,PERIOD_D1,zXdaily))/Point;

         int nTL4daily=zXdaily;
         int MaxNTL4daily=zXdaily;
         double MaxBodyTL4daily=zXdaily;
         while(nTL4daily<(nOfCandleWdaily+zXdaily))
           {
            double BodyTL4daily=((iOpen(NULL,PERIOD_D1,nTL4daily)-iClose(NULL,PERIOD_D1,nTL4daily))/Point);
            double dyTL4daily=MathAbs(BodyTL4daily);
            if(dyTL4daily>MaxBodyTL4daily)
              {
               MaxBodyTL4daily=dyTL4daily;
               MaxNTL4daily=nTL4daily;
              }
            nTL4daily++;
           }

         int n2TL4daily=zXdaily;
         int MaxN2TL4daily=zXdaily;
         double MaxBody2TL4daily=zXdaily;
         while(n2TL4daily<(nOfCandleWdaily+zXdaily))
           {
            double Body2TL4daily=((iOpen(NULL,PERIOD_D1,n2TL4daily)-iClose(NULL,PERIOD_D1,n2TL4daily))/Point);
            double dy2TL4daily=MathAbs(Body2TL4daily);
            if(dy2TL4daily<MaxBodyTL4daily && dy2TL4daily>MaxBody2TL4daily)
              {
               MaxBody2TL4daily=dy2TL4daily;
               MaxN2TL4daily=n2TL4daily;
              }
            n2TL4daily++;
           }

         double darsadTL4daily=(BodyzXdaily/((MaxBodyTL4daily+MaxBody2TL4daily)/2))*100;

         double candlesizeTL4daily;
         if(darsadTL4daily>=61)
            candlesizeTL4daily=4;
         if(darsadTL4daily<61 && darsadTL4daily>=41)
            candlesizeTL4daily=3;
         if(darsadTL4daily<41 && darsadTL4daily>5)
            candlesizeTL4daily=2;
         if(darsadTL4daily<=5)
            candlesizeTL4daily=1;

         if(iLow(NULL,PERIOD_D1,zXdaily)>minTL2daily+((TLdaily-LLdaily)/variable) && iLow(NULL,PERIOD_D1,zXdaily)<minTL2daily+(TLdaily-LLdaily) && candlesizeTL4daily<3 && downshadowzXdaily>=BodyzXdaily)
           {
            TL4daily=iLow(NULL,PERIOD_D1,zXdaily);
            if(TL4daily<minTL4daily)minTL4daily=TL4daily;
            ObjectCreate("ML TL4 Candid W1daily-"+zXdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zXdaily),iHigh(NULL,PERIOD_D1,zXdaily));
            ObjectSet("ML TL4 Candid W1daily-"+zXdaily,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML TL4 Candid W1daily-"+zXdaily,OBJPROP_COLOR,Brown);
            ObjectSet("ML TL4 Candid W1daily-"+zXdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
           }
         if(iLow(NULL,PERIOD_D1,zXdaily)>minTL2daily+((TLdaily-LLdaily)/variable) && candlesizeTL4daily>3 && iLow(NULL,PERIOD_D1,zXdaily)<minTL2daily+(TLdaily-LLdaily) && downshadowzXdaily>=(BodyzXdaily/4))
           {
            TL4daily=iLow(NULL,PERIOD_D1,zXdaily);
            if(TL4daily<minTL4daily)minTL4daily=TL4daily;
            ObjectCreate("ML TL4 Candid W2daily-"+zXdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zXdaily),iHigh(NULL,PERIOD_D1,zXdaily));
            ObjectSet("ML TL4 Candid W2daily-"+zXdaily,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML TL4 Candid W2daily-"+zXdaily,OBJPROP_COLOR,Brown);
            ObjectSet("ML TL4 Candid W2daily-"+zXdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
           }
         if(iLow(NULL,PERIOD_D1,zXdaily)>minTL2daily+((TLdaily-LLdaily)/variable) && iLow(NULL,PERIOD_D1,zXdaily)<minTL2daily+(TLdaily-LLdaily) && iClose(NULL,PERIOD_D1,zXdaily)<iOpen(NULL,PERIOD_D1,zXdaily) && iHigh(NULL,PERIOD_D1,(zXdaily-1))>((0.45*BodyzXdaily*Point)+iClose(NULL,PERIOD_D1,zXdaily)) && candlesizeTL4daily>3)
           {
            TL4daily=iLow(NULL,PERIOD_D1,zXdaily);
            if(TL4daily<minTL4daily)minTL4daily=TL4daily;
            ObjectCreate("ML TL4 Candid W3daily-"+zXdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zXdaily),iHigh(NULL,PERIOD_D1,zXdaily));
            ObjectSet("ML TL4 Candid W3daily-"+zXdaily,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML TL4 Candid W3daily-"+zXdaily,OBJPROP_COLOR,Brown);
            ObjectSet("ML TL4 Candid W3daily-"+zXdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
           }

         zXdaily++;
        }

      if(minTL4daily==minTL2daily+(TLdaily-LLdaily) || minTL4daily>=minTL2daily+((minTL2daily-TLdaily)/variable2))
        {
         int shoroLXXdaily=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_D1,q));
         ObjectCreate("ML shoroLD1XXdaily-"+shoroLXXdaily,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,shoroLXXdaily-1),iLow(NULL,PERIOD_H4,shoroLXXdaily-1));
         ObjectSet("ML shoroLD1XXdaily-"+shoroLXXdaily,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroLD1XXdaily-"+shoroLXXdaily,OBJPROP_COLOR,Red);
         ObjectSet("ML shoroLD1XXdaily-"+shoroLXXdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);

         int zXXdaily=q;
         int nzXXdaily=q;
         int countXXdaily=0;
         double BodyzXXdaily;
         double upshadowzXXdaily;
         double downshadowzXXdaily;

         while(zXXdaily<(iBars(NULL,PERIOD_H4)-1) && countXXdaily<=MaxTPSLCalcdaily && countXXdaily<=iBars(NULL,PERIOD_H4)-2-zXXdaily)
           {
            if(iClose(NULL,PERIOD_H4,zXXdaily)>iOpen(NULL,PERIOD_H4,zXXdaily))
              {
               upshadowzXXdaily=MathAbs((iHigh(NULL,PERIOD_H4,zXXdaily)-iClose(NULL,PERIOD_H4,zXXdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H4,zXXdaily)<iOpen(NULL,PERIOD_H4,zXXdaily))
              {
               upshadowzXXdaily=MathAbs((iHigh(NULL,PERIOD_H4,zXXdaily)-iOpen(NULL,PERIOD_H4,zXXdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H4,zXXdaily)>iOpen(NULL,PERIOD_H4,zXXdaily))
              {
               downshadowzXXdaily=MathAbs((iLow(NULL,PERIOD_H4,zXXdaily)-iOpen(NULL,PERIOD_H4,zXXdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H4,zXXdaily)<iOpen(NULL,PERIOD_H4,zXXdaily))
              {
               downshadowzXXdaily=MathAbs((iLow(NULL,PERIOD_H4,zXXdaily)-iClose(NULL,PERIOD_H4,zXXdaily)+(1*Point))/Point);
              }

            BodyzXXdaily=MathAbs(iClose(NULL,PERIOD_H4,zXXdaily)-iOpen(NULL,PERIOD_H4,zXXdaily))/Point;

            int nTL4Xdaily=zXXdaily;
            int MaxNTL4Xdaily=zXXdaily;
            double MaxBodyTL4Xdaily=zXXdaily;
            while(nTL4Xdaily<(nOfCandleWdaily+zXXdaily))
              {
               double BodyTL4Xdaily=((iOpen(NULL,PERIOD_H4,nTL4Xdaily)-iClose(NULL,PERIOD_H4,nTL4Xdaily))/Point);
               double dyTL4Xdaily=MathAbs(BodyTL4Xdaily);
               if(dyTL4Xdaily>MaxBodyTL4Xdaily)
                 {
                  MaxBodyTL4Xdaily=dyTL4Xdaily;
                  MaxNTL4Xdaily=nTL4Xdaily;
                 }
               nTL4Xdaily++;
              }

            int n2TL4Xdaily=zXXdaily;
            int MaxN2TL4Xdaily=zXXdaily;
            double MaxBody2TL4Xdaily=zXXdaily;
            while(n2TL4Xdaily<(nOfCandleWdaily+zXXdaily))
              {
               double Body2TL4Xdaily=((iOpen(NULL,PERIOD_H4,n2TL4Xdaily)-iClose(NULL,PERIOD_H4,n2TL4Xdaily))/Point);
               double dy2TL4Xdaily=MathAbs(Body2TL4Xdaily);
               if(dy2TL4Xdaily<MaxBodyTL4Xdaily && dy2TL4Xdaily>MaxBody2TL4Xdaily)
                 {
                  MaxBody2TL4Xdaily=dy2TL4Xdaily;
                  MaxN2TL4Xdaily=n2TL4Xdaily;
                 }
               n2TL4Xdaily++;
              }

            double darsadTL4Xdaily=(BodyzXXdaily/((MaxBodyTL4Xdaily+MaxBody2TL4Xdaily)/2))*100;

            double candlesizeTL4Xdaily;
            if(darsadTL4Xdaily>=61)
               candlesizeTL4Xdaily=4;
            if(darsadTL4Xdaily<61 && darsadTL4Xdaily>=41)
               candlesizeTL4Xdaily=3;
            if(darsadTL4Xdaily<41 && darsadTL4Xdaily>5)
               candlesizeTL4Xdaily=2;
            if(darsadTL4Xdaily<=5)
               candlesizeTL4Xdaily=1;

            if(iLow(NULL,PERIOD_H4,zXXdaily)>minTL2daily+((TLdaily-LLdaily)/variable) && iLow(NULL,PERIOD_H4,zXXdaily)<minTL2daily+(TLdaily-LLdaily) && candlesizeTL4Xdaily<3 && downshadowzXXdaily>=BodyzXXdaily)
              {
               TL4daily=iLow(NULL,PERIOD_H4,zXXdaily);
               if(TL4daily<minTL4daily)minTL4daily=TL4daily;
               ObjectCreate("ML TL4X Candid W1daily-"+zXXdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zXXdaily),iHigh(NULL,PERIOD_H4,zXXdaily));
               ObjectSet("ML TL4X Candid W1daily-"+zXXdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4X Candid W1daily-"+zXXdaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4X Candid W1daily-"+zXXdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
              }
            if(iLow(NULL,PERIOD_H4,zXXdaily)>minTL2daily+((TLdaily-LLdaily)/variable) && candlesizeTL4Xdaily>3 && iLow(NULL,PERIOD_H4,zXXdaily)<minTL2daily+(TLdaily-LLdaily) && downshadowzXXdaily>=(BodyzXXdaily/4))
              {
               TL4daily=iLow(NULL,PERIOD_H4,zXXdaily);
               if(TL4daily<minTL4daily)minTL4daily=TL4daily;
               ObjectCreate("ML TL4X Candid W2daily-"+zXXdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zXXdaily),iHigh(NULL,PERIOD_H4,zXXdaily));
               ObjectSet("ML TL4X Candid W2daily-"+zXXdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4X Candid W2daily-"+zXXdaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4X Candid W2daily-"+zXXdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
              }
            if(iLow(NULL,PERIOD_H4,zXXdaily)>minTL2daily+((TLdaily-LLdaily)/variable) && iLow(NULL,PERIOD_H4,zXXdaily)<minTL2daily+(TL-LLdaily) && iClose(NULL,PERIOD_H4,zXXdaily)<iOpen(NULL,PERIOD_H4,zXXdaily) && iHigh(NULL,PERIOD_H4,(zXXdaily-1))>((0.45*BodyzXXdaily*Point)+iClose(NULL,PERIOD_H4,zXXdaily)) && candlesizeTL4Xdaily>3)
              {
               TL4daily=iLow(NULL,PERIOD_H4,zXXdaily);
               if(TL4daily<minTL4daily)minTL4daily=TL4daily;
               ObjectCreate("ML TL4X Candid W3daily-"+zXXdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zXXdaily),iHigh(NULL,PERIOD_H4,zXXdaily));
               ObjectSet("ML TL4X Candid W3daily-"+zXXdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4X Candid W3daily-"+zXXdaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4X Candid W3daily-"+zXXdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
              }

            zXXdaily++;
           }

        }

      if(minTL4daily==minTL2daily+(TLdaily-LLdaily) || minTL4daily>=minTL2daily+((minTL2daily-TLdaily)/variable2))
        {
         int shoroLXXXdaily=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q));
         ObjectCreate("ML shoroLD1XXXdaily-"+shoroLXXXdaily,OBJ_VLINE,0,iTime(NULL,PERIOD_H1,shoroLXXXdaily-1),iLow(NULL,PERIOD_H1,shoroLXXXdaily-1));
         ObjectSet("ML shoroLD1XXXdaily-"+shoroLXXXdaily,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroLD1XXXdaily-"+shoroLXXXdaily,OBJPROP_COLOR,Red);
         ObjectSet("ML shoroLD1XXXdaily-"+shoroLXXXdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);

         int zXXXdaily=q;
         int nzXXXdaily=q;
         int countXXXdaily=0;
         double BodyzXXXdaily;
         double upshadowzXXXdaily;
         double downshadowzXXXdaily;

         while(zXXXdaily<(iBars(NULL,PERIOD_H1)-1) && countXXXdaily<=MaxTPSLCalcdaily && countXXXdaily<=iBars(NULL,PERIOD_H1)-2-zXXXdaily)
           {
            if(iClose(NULL,PERIOD_H1,zXXXdaily)>iOpen(NULL,PERIOD_H1,zXXXdaily))
              {
               upshadowzXXXdaily=MathAbs((iHigh(NULL,PERIOD_H1,zXXXdaily)-iClose(NULL,PERIOD_H1,zXXXdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H1,zXXXdaily)<iOpen(NULL,PERIOD_H1,zXXXdaily))
              {
               upshadowzXXXdaily=MathAbs((iHigh(NULL,PERIOD_H1,zXXXdaily)-iOpen(NULL,PERIOD_H1,zXXXdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H1,zXXXdaily)>iOpen(NULL,PERIOD_H1,zXXXdaily))
              {
               downshadowzXXXdaily=MathAbs((iLow(NULL,PERIOD_H1,zXXXdaily)-iOpen(NULL,PERIOD_H1,zXXXdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H1,zXXXdaily)<iOpen(NULL,PERIOD_H1,zXXXdaily))
              {
               downshadowzXXXdaily=MathAbs((iLow(NULL,PERIOD_H1,zXXXdaily)-iClose(NULL,PERIOD_H1,zXXXdaily)+(1*Point))/Point);
              }

            BodyzXXXdaily=MathAbs(iClose(NULL,PERIOD_H1,zXXXdaily)-iOpen(NULL,PERIOD_H1,zXXXdaily))/Point;

            int nTL4XXdaily=zXXXdaily;
            int MaxNTL4XXdaily=zXXXdaily;
            double MaxBodyTL4XXdaily=zXXXdaily;
            while(nTL4XXdaily<(nOfCandleWdaily+zXXXdaily))
              {
               double BodyTL4XXdaily=((iOpen(NULL,PERIOD_H1,nTL4XXdaily)-iClose(NULL,PERIOD_H1,nTL4XXdaily))/Point);
               double dyTL4XXdaily=MathAbs(BodyTL4XXdaily);
               if(dyTL4XXdaily>MaxBodyTL4XXdaily)
                 {
                  MaxBodyTL4XXdaily=dyTL4XXdaily;
                  MaxNTL4XXdaily=nTL4XXdaily;
                 }
               nTL4XXdaily++;
              }

            int n2TL4XXdaily=zXXXdaily;
            int MaxN2TL4XXdaily=zXXXdaily;
            double MaxBody2TL4XXdaily=zXXXdaily;
            while(n2TL4XXdaily<(nOfCandleWdaily+zXXXdaily))
              {
               double Body2TL4XXdaily=((iOpen(NULL,PERIOD_H1,n2TL4XXdaily)-iClose(NULL,PERIOD_H1,n2TL4XXdaily))/Point);
               double dy2TL4XXdaily=MathAbs(Body2TL4XXdaily);
               if(dy2TL4XXdaily<MaxBodyTL4XXdaily && dy2TL4XXdaily>MaxBody2TL4XXdaily)
                 {
                  MaxBody2TL4XXdaily=dy2TL4XXdaily;
                  MaxN2TL4XXdaily=n2TL4XXdaily;
                 }
               n2TL4XXdaily++;
              }

            double darsadTL4XXdaily=(BodyzXXXdaily/((MaxBodyTL4XXdaily+MaxBody2TL4XXdaily)/2))*100;

            double candlesizeTL4XXdaily;
            if(darsadTL4XXdaily>=61)
               candlesizeTL4XXdaily=4;
            if(darsadTL4XXdaily<61 && darsadTL4XXdaily>=41)
               candlesizeTL4XXdaily=3;
            if(darsadTL4XXdaily<41 && darsadTL4XXdaily>5)
               candlesizeTL4XXdaily=2;
            if(darsadTL4XXdaily<=5)
               candlesizeTL4XXdaily=1;

            if(iLow(NULL,PERIOD_H1,zXXXdaily)>minTL2daily+((TLdaily-LLdaily)/variable) && iLow(NULL,PERIOD_H1,zXXXdaily)<minTL2daily+(TLdaily-LLdaily) && candlesizeTL4XXdaily<3 && downshadowzXXXdaily>=BodyzXXXdaily)
              {
               TL4daily=iLow(NULL,PERIOD_H1,zXXXdaily);
               if(TL4daily<minTL4daily)minTL4daily=TL4daily;
               ObjectCreate("ML TL4XX Candid W1daily-"+zXXXdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H1,zXXXdaily),iHigh(NULL,PERIOD_H1,zXXXdaily));
               ObjectSet("ML TL4XX Candid W1daily-"+zXXXdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4XX Candid W1daily-"+zXXXdaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4XX Candid W1daily-"+zXXXdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
              }
            if(iLow(NULL,PERIOD_H1,zXXXdaily)>minTL2daily+((TLdaily-LLdaily)/variable) && candlesizeTL4XXdaily>3 && iLow(NULL,PERIOD_H1,zXXXdaily)<minTL2daily+(TLdaily-LLdaily) && downshadowzXXXdaily>=(BodyzXXXdaily/4))
              {
               TL4daily=iLow(NULL,PERIOD_H1,zXXXdaily);
               if(TL4daily<minTL4daily)minTL4daily=TL4daily;
               ObjectCreate("ML TL4XX Candid W2daily-"+zXXXdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H1,zXXXdaily),iHigh(NULL,PERIOD_H1,zXXXdaily));
               ObjectSet("ML TL4XX Candid W2daily-"+zXXXdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4XX Candid W2daily-"+zXXXdaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4XX Candid W2daily-"+zXXXdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
              }
            if(iLow(NULL,PERIOD_H1,zXXXdaily)>minTL2daily+((TLdaily-LLdaily)/variable) && iLow(NULL,PERIOD_H1,zXXXdaily)<minTL2daily+(TLdaily-LLdaily) && iClose(NULL,PERIOD_H1,zXXXdaily)<iOpen(NULL,PERIOD_H1,zXXXdaily) && iHigh(NULL,PERIOD_H1,(zXXXdaily-1))>((0.45*BodyzXXXdaily*Point)+iClose(NULL,PERIOD_H1,zXXXdaily)) && candlesizeTL4XXdaily>3)
              {
               TL4daily=iLow(NULL,PERIOD_H1,zXXXdaily);
               if(TL4daily<minTL4daily)minTL4daily=TL4daily;
               ObjectCreate("ML TL4XX Candid W3daily-"+zXXXdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H1,zXXXdaily),iHigh(NULL,PERIOD_H1,zXXXdaily));
               ObjectSet("ML TL4XX Candid W3daily-"+zXXXdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4XX Candid W3daily-"+zXXXdaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4XX Candid W3daily-"+zXXXdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
              }

            zXXXdaily++;
           }

        }
      int zX2daily=q;
      int nzX2daily=q;
      int countX2daily=0;
      double BodyzX2daily;
      double upshadowzX2daily;
      double downshadowzX2daily;
      minTL3daily=minTL2daily;

      while(zX2daily<(iBars(NULL,PERIOD_D1)-1) && countX2daily<=MaxTPSLCalcdaily && countX2daily<=iBars(NULL,PERIOD_D1)-2-zX2daily)
        {
         if(iClose(NULL,PERIOD_D1,zX2daily)>iOpen(NULL,PERIOD_D1,zX2daily))
           {
            upshadowzX2daily=MathAbs((iHigh(NULL,PERIOD_D1,zX2daily)-iClose(NULL,PERIOD_D1,zX2daily)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_D1,zX2daily)<iOpen(NULL,PERIOD_D1,zX2daily))
           {
            upshadowzX2daily=MathAbs((iHigh(NULL,PERIOD_D1,zX2daily)-iOpen(NULL,PERIOD_D1,zX2daily)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_D1,zX2daily)>iOpen(NULL,PERIOD_D1,zX2daily))
           {
            downshadowzX2daily=MathAbs((iLow(NULL,PERIOD_D1,zX2daily)-iOpen(NULL,PERIOD_D1,zX2daily)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_D1,zX2daily)<iOpen(NULL,PERIOD_D1,zX2daily))
           {
            downshadowzX2daily=MathAbs((iLow(NULL,PERIOD_D1,zX2daily)-iClose(NULL,PERIOD_D1,zX2daily)+(1*Point))/Point);
           }

         BodyzX2daily=MathAbs(iClose(NULL,PERIOD_D1,zX2daily)-iOpen(NULL,PERIOD_D1,zX2daily))/Point;

         int nTL3daily=zX2daily;
         int MaxNTL3daily=zX2daily;
         double MaxBodyTL3daily=zX2daily;
         while(nTL3daily<(nOfCandleWdaily+zX2daily))
           {
            double BodyTL3daily=((iOpen(NULL,PERIOD_D1,nTL3daily)-iClose(NULL,PERIOD_D1,nTL3daily))/Point);
            double dyTL3daily=MathAbs(BodyTL3daily);
            if(dyTL3daily>MaxBodyTL3daily)
              {
               MaxBodyTL3daily=dyTL3daily;
               MaxNTL3daily=nTL3daily;
              }
            nTL3daily++;
           }

         int n2TL3daily=zX2daily;
         int MaxN2TL3daily=zX2daily;
         double MaxBody2TL3daily=zX2daily;
         while(n2TL3daily<(nOfCandleWdaily+zX2daily))
           {
            double Body2TL3daily=((iOpen(NULL,PERIOD_D1,n2TL3daily)-iClose(NULL,PERIOD_D1,n2TL3daily))/Point);
            double dy2TL3daily=MathAbs(Body2TL3daily);
            if(dy2TL3daily<MaxBodyTL3daily && dy2TL3daily>MaxBody2TL3daily)
              {
               MaxBody2TL3daily=dy2TL3daily;
               MaxN2TL3daily=n2TL3daily;
              }
            n2TL3daily++;
           }

         double darsadTL3daily=(BodyzX2daily/((MaxBodyTL3daily+MaxBody2TL3daily)/2))*100;

         double candlesizeTL3daily;
         if(darsadTL3daily>=61)
            candlesizeTL3daily=4;
         if(darsadTL3daily<61 && darsadTL3daily>=41)
            candlesizeTL3daily=3;
         if(darsadTL3daily<41 && darsadTL3daily>5)
            candlesizeTL3daily=2;
         if(darsadTL3daily<=5)
            candlesizeTL3daily=1;

         minTL3daily=minTL2daily;

         if(iLow(NULL,PERIOD_D1,zX2daily)>TLdaily+((TLdaily-LLdaily)/variable) && iLow(NULL,PERIOD_D1,zX2daily)<minTL2daily && candlesizeTL3daily<3 && downshadowzX2daily>=BodyzX2daily)
           {
            TL3daily=iLow(NULL,PERIOD_D1,zX2daily);
            if(TL3daily<minTL3daily)minTL3daily=TL3daily;
            ObjectCreate("ML TL3 Candid W1daily-"+zX2daily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zX2daily),iHigh(NULL,PERIOD_D1,zX2daily));
            ObjectSet("ML TL3 Candid W1daily-"+zX2daily,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML TL3 Candid W1daily-"+zX2daily,OBJPROP_COLOR,Yellow);
            ObjectSet("ML TL3 Candid W1daily-"+zX2daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
           }
         if(iLow(NULL,PERIOD_D1,zX2daily)>TLdaily+((TLdaily-LLdaily)/variable) && candlesizeTL3daily>3 && iLow(NULL,PERIOD_D1,zX2daily)<minTL2daily && downshadowzX2daily>=(BodyzX2daily/4))
           {
            TL3daily=iLow(NULL,PERIOD_D1,zX2);
            if(TL3daily<minTL3daily)minTL3daily=TL3daily;
            ObjectCreate("ML TL3 Candid W2daily-"+zX2daily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zX2daily),iHigh(NULL,PERIOD_D1,zX2daily));
            ObjectSet("ML TL3 Candid W2daily-"+zX2daily,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML TL3 Candid W2daily-"+zX2daily,OBJPROP_COLOR,Yellow);
            ObjectSet("ML TL3 Candid W2daily-"+zX2daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
           }
         if(iLow(NULL,PERIOD_D1,zX2daily)>TLdaily+((TLdaily-LLdaily)/variable) && iLow(NULL,PERIOD_D1,zX2daily)<minTL2 && iClose(NULL,PERIOD_D1,zX2daily)<iOpen(NULL,PERIOD_D1,zX2daily) && iHigh(NULL,PERIOD_D1,(zX2daily-1))>((0.45*BodyzX2daily*Point)+iClose(NULL,PERIOD_D1,zX2daily)) && candlesizeTL3daily>3)
           {
            TL3daily=iLow(NULL,PERIOD_D1,zX2daily);
            if(TL3daily<minTL3daily)minTL3daily=TL3daily;
            ObjectCreate("ML TL4 Candid W3daily-"+zX2daily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zX2daily),iHigh(NULL,PERIOD_D1,zX2daily));
            ObjectSet("ML TL4 Candid W3daily-"+zX2daily,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML TL4 Candid W3daily-"+zX2daily,OBJPROP_COLOR,Brown);
            ObjectSet("ML TL4 Candid W3daily-"+zX2daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
           }

         zX2daily++;
        }

      if(minTL3daily==minTL2daily || minTL3daily>=TLdaily+((minTL2daily-TLdaily)/variable2))
        {
         int shoroLXXLdaily=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_D1,q));
         ObjectCreate("ML shoroLD1XXdaily-"+shoroLXXLdaily,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,shoroLXXLdaily-1),iLow(NULL,PERIOD_H4,shoroLXXLdaily-1));
         ObjectSet("ML shoroLD1XXdaily-"+shoroLXXLdaily,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroLD1XXdaily-"+shoroLXXLdaily,OBJPROP_COLOR,Red);
         ObjectSet("ML shoroLD1XXdaily-"+shoroLXXLdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);

         int zX2Ydaily=q;
         int nzX2Ydaily=q;
         int countX2Ydaily=0;
         double BodyzX2Ydaily;
         double upshadowzX2Ydaily;
         double downshadowzX2Ydaily;
         minTL3daily=minTL2daily;

         while(zX2Ydaily<(iBars(NULL,PERIOD_H4)-1) && countX2Ydaily<=MaxTPSLCalcdaily && countX2Ydaily<=iBars(NULL,PERIOD_H4)-2-zX2Ydaily)
           {
            if(iClose(NULL,PERIOD_H4,zX2Ydaily)>iOpen(NULL,PERIOD_H4,zX2Ydaily))
              {
               upshadowzX2Ydaily=MathAbs((iHigh(NULL,PERIOD_H4,zX2Ydaily)-iClose(NULL,PERIOD_H4,zX2Ydaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H4,zX2Ydaily)<iOpen(NULL,PERIOD_H4,zX2Ydaily))
              {
               upshadowzX2Ydaily=MathAbs((iHigh(NULL,PERIOD_H4,zX2Ydaily)-iOpen(NULL,PERIOD_H4,zX2Ydaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H4,zX2Ydaily)>iOpen(NULL,PERIOD_H4,zX2Ydaily))
              {
               downshadowzX2Ydaily=MathAbs((iLow(NULL,PERIOD_H4,zX2Ydaily)-iOpen(NULL,PERIOD_H4,zX2Ydaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H4,zX2Ydaily)<iOpen(NULL,PERIOD_H4,zX2Ydaily))
              {
               downshadowzX2Ydaily=MathAbs((iLow(NULL,PERIOD_H4,zX2Ydaily)-iClose(NULL,PERIOD_H4,zX2Ydaily)+(1*Point))/Point);
              }

            BodyzX2Ydaily=MathAbs(iClose(NULL,PERIOD_H4,zX2Ydaily)-iOpen(NULL,PERIOD_H4,zX2Ydaily))/Point;

            int nTL3Ydaily=zX2Ydaily;
            int MaxNTL3Ydaily=zX2Ydaily;
            double MaxBodyTL3Ydaily=zX2Ydaily;
            while(nTL3Ydaily<(nOfCandleWdaily+zX2Ydaily))
              {
               double BodyTL3Ydaily=((iOpen(NULL,PERIOD_H4,nTL3Ydaily)-iClose(NULL,PERIOD_H4,nTL3Ydaily))/Point);
               double dyTL3Ydaily=MathAbs(BodyTL3Ydaily);
               if(dyTL3Ydaily>MaxBodyTL3Ydaily)
                 {
                  MaxBodyTL3Ydaily=dyTL3Ydaily;
                  MaxNTL3Ydaily=nTL3Ydaily;
                 }
               nTL3Ydaily++;
              }

            int n2TL3Ydaily=zX2Ydaily;
            int MaxN2TL3Ydaily=zX2Ydaily;
            double MaxBody2TL3Ydaily=zX2Ydaily;
            while(n2TL3Ydaily<(nOfCandleWdaily+zX2Ydaily))
              {
               double Body2TL3Ydaily=((iOpen(NULL,PERIOD_H4,n2TL3Ydaily)-iClose(NULL,PERIOD_H4,n2TL3Ydaily))/Point);
               double dy2TL3Ydaily=MathAbs(Body2TL3Ydaily);
               if(dy2TL3Ydaily<MaxBodyTL3Ydaily && dy2TL3Ydaily>MaxBody2TL3Ydaily)
                 {
                  MaxBody2TL3Ydaily=dy2TL3Ydaily;
                  MaxN2TL3Ydaily=n2TL3Ydaily;
                 }
               n2TL3Ydaily++;
              }

            double darsadTL3Ydaily=(BodyzX2Ydaily/((MaxBodyTL3Ydaily+MaxBody2TL3Ydaily)/2))*100;

            double candlesizeTL3Ydaily;
            if(darsadTL3Ydaily>=61)
               candlesizeTL3Ydaily=4;
            if(darsadTL3Ydaily<61 && darsadTL3Ydaily>=41)
               candlesizeTL3Ydaily=3;
            if(darsadTL3Ydaily<41 && darsadTL3Ydaily>5)
               candlesizeTL3Ydaily=2;
            if(darsadTL3Ydaily<=5)
               candlesizeTL3Ydaily=1;

            if(iLow(NULL,PERIOD_H4,zX2Ydaily)>TLdaily+((TLdaily-LLdaily)/variable) && iLow(NULL,PERIOD_H4,zX2Ydaily)<minTL2daily && candlesizeTL3Ydaily<3 && downshadowzX2Ydaily>=BodyzX2Ydaily)
              {
               TL3daily=iLow(NULL,PERIOD_H4,zX2Ydaily);
               if(TL3daily<minTL3daily)minTL3daily=TL3daily;
               ObjectCreate("ML TL3Y Candid W1daily-"+zX2Ydaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zX2Ydaily),iHigh(NULL,PERIOD_H4,zX2Ydaily));
               ObjectSet("ML TL3Y Candid W1daily-"+zX2Ydaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL3Y Candid W1daily-"+zX2Ydaily,OBJPROP_COLOR,Yellow);
               ObjectSet("ML TL3Y Candid W1daily-"+zX2Ydaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
              }
            if(iLow(NULL,PERIOD_H4,zX2Y)>TLdaily+((TLdaily-LLdaily)/variable) && candlesizeTL3Y>3 && iLow(NULL,PERIOD_H4,zX2Ydaily)<minTL2daily && downshadowzX2Ydaily>=(BodyzX2Ydaily/4))
              {
               TL3daily=iLow(NULL,PERIOD_H4,zX2Ydaily);
               if(TL3daily<minTL3daily)minTL3daily=TL3daily;
               ObjectCreate("ML TL3Y Candid W2daily-"+zX2Ydaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zX2Ydaily),iHigh(NULL,PERIOD_H4,zX2Ydaily));
               ObjectSet("ML TL3Y Candid W2daily-"+zX2Ydaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL3Y Candid W2daily-"+zX2Ydaily,OBJPROP_COLOR,Yellow);
               ObjectSet("ML TL3Y Candid W2daily-"+zX2Ydaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
              }
            if(iLow(NULL,PERIOD_H4,zX2Ydaily)>TLdaily+((TLdaily-LLdaily)/variable) && iLow(NULL,PERIOD_H4,zX2Ydaily)<minTL2daily && iClose(NULL,PERIOD_H4,zX2Ydaily)<iOpen(NULL,PERIOD_H4,zX2Ydaily) && iHigh(NULL,PERIOD_H4,(zX2Ydaily-1))>iClose(NULL,PERIOD_H4,zX2Ydaily)+(0.45*BodyzX2Ydaily*Point) && candlesizeTL3Ydaily>3)
              {
               TL4daily=iLow(NULL,PERIOD_H4,zX2Ydaily);
               if(TL3daily<minTL3daily)minTL3daily=TL3daily;
               ObjectCreate("ML TL4Y Candid W3daily-"+zX2Ydaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zX2Ydaily),iHigh(NULL,PERIOD_H4,zX2Ydaily));
               ObjectSet("ML TL4Y Candid W3daily-"+zX2Ydaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4Y Candid W3daily-"+zX2Ydaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4Y Candid W3daily-"+zX2Ydaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
              }

            zX2Ydaily++;
           }

        }

      if(minTL3daily==minTL2daily || minTL3daily>=TLdaily+((minTL2daily-TLdaily)/variable2))
        {
         int shoroLXXLLdaily=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q));
         ObjectCreate("ML shoroLD1XXLdaily-"+shoroLXXLLdaily,OBJ_VLINE,0,iTime(NULL,PERIOD_H1,shoroLXXLLdaily-1),iLow(NULL,PERIOD_H1,shoroLXXLLdaily-1));
         ObjectSet("ML shoroLD1XXLdaily-"+shoroLXXLLdaily,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroLD1XXLdaily-"+shoroLXXLLdaily,OBJPROP_COLOR,Red);
         ObjectSet("ML shoroLD1XXLdaily-"+shoroLXXLLdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);

         int zX2YYdaily=q;
         int nzX2YYdaily=q;
         int countX2YYdaily=0;
         double BodyzX2YYdaily;
         double upshadowzX2YYdaily;
         double downshadowzX2YYdaily;
         minTL3daily=minTL2daily;

         while(zX2YYdaily<(iBars(NULL,PERIOD_H1)-1) && countX2YYdaily<=MaxTPSLCalcdaily && countX2YYdaily<=iBars(NULL,PERIOD_H1)-2-zX2YYdaily)
           {
            if(iClose(NULL,PERIOD_H1,zX2YYdaily)>iOpen(NULL,PERIOD_H1,zX2YYdaily))
              {
               upshadowzX2YYdaily=MathAbs((iHigh(NULL,PERIOD_H1,zX2YYdaily)-iClose(NULL,PERIOD_H1,zX2YYdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H1,zX2YYdaily)<iOpen(NULL,PERIOD_H1,zX2YYdaily))
              {
               upshadowzX2YYdaily=MathAbs((iHigh(NULL,PERIOD_H1,zX2YYdaily)-iOpen(NULL,PERIOD_H1,zX2YYdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H1,zX2YYdaily)>iOpen(NULL,PERIOD_H1,zX2YYdaily))
              {
               downshadowzX2YYdaily=MathAbs((iLow(NULL,PERIOD_H1,zX2YYdaily)-iOpen(NULL,PERIOD_H1,zX2YYdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H1,zX2YYdaily)<iOpen(NULL,PERIOD_H1,zX2YYdaily))
              {
               downshadowzX2YYdaily=MathAbs((iLow(NULL,PERIOD_H1,zX2YYdaily)-iClose(NULL,PERIOD_H1,zX2YYdaily)+(1*Point))/Point);
              }

            BodyzX2YYdaily=MathAbs(iClose(NULL,PERIOD_H1,zX2YYdaily)-iOpen(NULL,PERIOD_H1,zX2YYdaily))/Point;

            int nTL3YYdaily=zX2YYdaily;
            int MaxNTL3YYdaily=zX2YYdaily;
            double MaxBodyTL3YYdaily=zX2YYdaily;
            while(nTL3YYdaily<(nOfCandleWdaily+zX2YYdaily))
              {
               double BodyTL3YYdaily=((iOpen(NULL,PERIOD_H1,nTL3YYdaily)-iClose(NULL,PERIOD_H1,nTL3YYdaily))/Point);
               double dyTL3YYdaily=MathAbs(BodyTL3YYdaily);
               if(dyTL3YYdaily>MaxBodyTL3YYdaily)
                 {
                  MaxBodyTL3YYdaily=dyTL3YYdaily;
                  MaxNTL3YYdaily=nTL3YYdaily;
                 }
               nTL3YYdaily++;
              }

            int n2TL3YYdaily=zX2YYdaily;
            int MaxN2TL3YYdaily=zX2YYdaily;
            double MaxBody2TL3YYdaily=zX2YYdaily;
            while(n2TL3YYdaily<(nOfCandleWdaily+zX2YYdaily))
              {
               double Body2TL3YYdaily=((iOpen(NULL,PERIOD_H1,n2TL3YYdaily)-iClose(NULL,PERIOD_H1,n2TL3YYdaily))/Point);
               double dy2TL3YYdaily=MathAbs(Body2TL3YYdaily);
               if(dy2TL3YYdaily<MaxBodyTL3YYdaily && dy2TL3YYdaily>MaxBody2TL3YYdaily)
                 {
                  MaxBody2TL3YYdaily=dy2TL3YYdaily;
                  MaxN2TL3YYdaily=n2TL3YYdaily;
                 }
               n2TL3YYdaily++;
              }

            double darsadTL3YYdaily=(BodyzX2YYdaily/((MaxBodyTL3YYdaily+MaxBody2TL3YYdaily)/2))*100;

            double candlesizeTL3YYdaily;
            if(darsadTL3YYdaily>=61)
               candlesizeTL3YYdaily=4;
            if(darsadTL3YYdaily<61 && darsadTL3YYdaily>=41)
               candlesizeTL3YYdaily=3;
            if(darsadTL3YYdaily<41 && darsadTL3YYdaily>5)
               candlesizeTL3YYdaily=2;
            if(darsadTL3YYdaily<=5)
               candlesizeTL3YYdaily=1;

            if(iLow(NULL,PERIOD_H1,zX2YYdaily)>TLdaily+((TLdaily-LLdaily)/variable) && iLow(NULL,PERIOD_H1,zX2YYdaily)<minTL2daily && candlesizeTL3YYdaily<3 && downshadowzX2YYdaily>=BodyzX2YYdaily)
              {
               TL3daily=iLow(NULL,PERIOD_H1,zX2YYdaily);
               if(TL3daily<minTL3daily)minTL3daily=TL3daily;
               ObjectCreate("ML TL3YY Candid W1daily-"+zX2YYdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H1,zX2YYdaily),iHigh(NULL,PERIOD_H1,zX2YYdaily));
               ObjectSet("ML TL3YY Candid W1daily-"+zX2YYdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL3YY Candid W1daily-"+zX2YYdaily,OBJPROP_COLOR,Yellow);
               ObjectSet("ML TL3YY Candid W1daily-"+zX2YYdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
              }
            if(iLow(NULL,PERIOD_H1,zX2YYdaily)>TLdaily+((TLdaily-LLdaily)/variable) && candlesizeTL3YYdaily>3 && iLow(NULL,PERIOD_H1,zX2YYdaily)<minTL2daily && downshadowzX2YYdaily>=(BodyzX2YYdaily/4))
              {
               TL3daily=iLow(NULL,PERIOD_H1,zX2YYdaily);
               if(TL3daily<minTL3daily)minTL3daily=TL3daily;
               ObjectCreate("ML TL3YY Candid W2daily-"+zX2YYdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H1,zX2YYdaily),iHigh(NULL,PERIOD_H1,zX2YYdaily));
               ObjectSet("ML TL3YY Candid W2daily-"+zX2YYdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL3YY Candid W2daily-"+zX2YYdaily,OBJPROP_COLOR,Yellow);
               ObjectSet("ML TL3YY Candid W2daily-"+zX2YYdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
              }
            if(iLow(NULL,PERIOD_H1,zX2YYdaily)>TLdaily+((TLdaily-LLdaily)/variable) && iLow(NULL,PERIOD_H1,zX2YYdaily)<minTL2daily && iClose(NULL,PERIOD_H1,zX2YYdaily)<iOpen(NULL,PERIOD_H1,zX2YYdaily) && iHigh(NULL,PERIOD_H1,(zX2YYdaily-1))>iClose(NULL,PERIOD_H1,zX2YYdaily)+(0.45*BodyzX2YYdaily*Point) && candlesizeTL3YYdaily>3)
              {
               TL4daily=iLow(NULL,PERIOD_H1,zX2YYdaily);
               if(TL3daily<minTL3daily)minTL3daily=TL3daily;
               ObjectCreate("ML TL4YY Candid W3daily-"+zX2YYdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H1,zX2YYdaily),iHigh(NULL,PERIOD_H1,zX2YYdaily));
               ObjectSet("ML TL4YY Candid W3daily-"+zX2YYdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML TL4YY Candid W3daily-"+zX2YYdaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML TL4YY Candid W3daily-"+zX2YYdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
              }

            zX2YYdaily++;
           }

        }

      int zQdaily=q;
      int nzQdaily=q;
      int countQdaily=0;
      double BodyzQdaily;
      double upshadowzQdaily;
      double downshadowzQdaily;
      minLL3daily=minLL2daily;

      while(zQdaily<(iBars(NULL,PERIOD_D1)-1) && countQdaily<=MaxTPSLCalcdaily && countQdaily<=iBars(NULL,PERIOD_D1)-2-zQdaily)
        {
         if(iClose(NULL,PERIOD_D1,zQdaily)>iOpen(NULL,PERIOD_D1,zQdaily))
           {
            upshadowzQdaily=MathAbs((iHigh(NULL,PERIOD_D1,zQdaily)-iClose(NULL,PERIOD_D1,zQdaily)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_D1,zQdaily)<iOpen(NULL,PERIOD_D1,zQdaily))
           {
            upshadowzQdaily=MathAbs((iHigh(NULL,PERIOD_D1,zQdaily)-iOpen(NULL,PERIOD_D1,zQdaily)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_D1,zQdaily)>iOpen(NULL,PERIOD_D1,zQdaily))
           {
            downshadowzQdaily=MathAbs((iLow(NULL,PERIOD_D1,zQdaily)-iOpen(NULL,PERIOD_D1,zQdaily)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_D1,zQdaily)<iOpen(NULL,PERIOD_D1,zQdaily))
           {
            downshadowzQdaily=MathAbs((iLow(NULL,PERIOD_D1,zQdaily)-iClose(NULL,PERIOD_D1,zQdaily)+(1*Point))/Point);
           }

         BodyzQdaily=MathAbs(iClose(NULL,PERIOD_D1,zQdaily)-iOpen(NULL,PERIOD_D1,zQdaily))/Point;

         int nLL3daily=zQdaily;
         int MaxNLL3daily=zQdaily;
         double MaxBodyLL3daily=zQdaily;
         while(nLL3daily<(nOfCandleWdaily+zQdaily))
           {
            double BodyLL3daily=((iOpen(NULL,PERIOD_D1,nLL3daily)-iClose(NULL,PERIOD_D1,nLL3daily))/Point);
            double dyLL3daily=MathAbs(BodyLL3daily);
            if(dyLL3daily>MaxBodyLL3daily)
              {
               MaxBodyLL3daily=dyLL3daily;
               MaxNLL3daily=nLL3daily;
              }
            nLL3daily++;
           }

         int n2LL3daily=zQdaily;
         int MaxN2LL3daily=zQdaily;
         double MaxBody2LL3daily=zQdaily;
         while(n2LL3daily<(nOfCandleWdaily+zQdaily))
           {
            double Body2LL3daily=((iOpen(NULL,PERIOD_D1,n2LL3daily)-iClose(NULL,PERIOD_D1,n2LL3daily))/Point);
            double dy2LL3daily=MathAbs(Body2LL3daily);
            if(dy2LL3daily<MaxBodyLL3daily && dy2LL3daily>MaxBody2LL3daily)
              {
               MaxBody2LL3daily=dy2LL3daily;
               MaxN2LL3daily=n2LL3daily;
              }
            n2LL3daily++;
           }

         double darsadLL3daily=(BodyzQdaily/((MaxBodyLL3daily+MaxBody2LL3daily)/2))*100;

         double candlesizeLL3daily;
         if(darsadLL3daily>=61)
            candlesizeLL3daily=4;
         if(darsadLL3daily<61 && darsadLL3daily>=41)
            candlesizeLL3daily=3;
         if(darsadLL3daily<41 && darsadLL3daily>5)
            candlesizeLL3daily=2;
         if(darsadLL3daily<=5)
            candlesizeLL3daily=1;

         if(iHigh(NULL,PERIOD_D1,zQdaily)<LLdaily-((TLdaily-LLdaily)/variable) && iHigh(NULL,PERIOD_D1,zQdaily)>minLL2daily && candlesizeLL3daily<3 && upshadowzQdaily>=BodyzQdaily)
           {
            LL3daily=iHigh(NULL,PERIOD_D1,zQdaily);
            if(LL3daily>minLL3daily)minLL3daily=LL3daily;
            ObjectCreate("ML LL3 Candid W1daily-"+zQdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zQdaily),iLow(NULL,PERIOD_D1,zQdaily));
            ObjectSet("ML LL3 Candid W1daily-"+zQdaily,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML LL3 Candid W1daily-"+zQdaily,OBJPROP_COLOR,Brown);
            ObjectSet("ML LL3 Candid W1daily-"+zQdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
           }
         if(iHigh(NULL,PERIOD_D1,zQdaily)<LLdaily-((TLdaily-LLdaily)/variable) && candlesizeLL3daily>3 && iHigh(NULL,PERIOD_D1,zQdaily)>minLL2daily && upshadowzQdaily>=(BodyzQdaily/4))
           {
            LL3=iHigh(NULL,PERIOD_D1,zQdaily);
            if(LL3daily>minLL3daily)minLL3daily=LL3daily;
            ObjectCreate("ML LL3 Candid W2daily-"+zQdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zQdaily),iHigh(NULL,PERIOD_D1,zQdaily));
            ObjectSet("ML LL3 Candid W2daily-"+zQdaily,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML LL3 Candid W2daily-"+zQdaily,OBJPROP_COLOR,Brown);
            ObjectSet("ML LL3 Candid W2daily-"+zQdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
           }
         if(iHigh(NULL,PERIOD_D1,zQdaily)<LLdaily-((TLdaily-LLdaily)/variable) && iHigh(NULL,PERIOD_D1,zQdaily)>minLL2daily && iClose(NULL,PERIOD_D1,zQdaily)>iOpen(NULL,PERIOD_D1,zQdaily) && iLow(NULL,PERIOD_D1,(zQdaily-1))<(iClose(NULL,PERIOD_D1,zQdaily)-(0.45*BodyzQdaily*Point)) && candlesizeLL3daily>3)
           {
            LL3daily=iHigh(NULL,PERIOD_D1,zQdaily);
            if(LL3daily>minLL3daily)minLL3daily=LL3daily;
            ObjectCreate("ML LL3 Candid W3daily-"+zQdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zQdaily),iHigh(NULL,PERIOD_D1,zQdaily));
            ObjectSet("ML LL3 Candid W3daily-"+zQdaily,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML LL3 Candid W3daily-"+zQdaily,OBJPROP_COLOR,Brown);
            ObjectSet("ML LL3 Candid W3daily-"+zQdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
           }

         zQdaily++;
        }

      if(minLL3daily==minLL2daily || minLL3daily<=LLdaily-((LLdaily-minLL2daily)/variable2))
        {
         int shoroLQQdaily=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_D1,q));
         ObjectCreate("ML shoroLD1QQdaily-"+shoroLQQdaily,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,shoroLQQdaily-1),iLow(NULL,PERIOD_H4,shoroLQQdaily-1));
         ObjectSet("ML shoroLD1QQdaily-"+shoroLQQdaily,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroLD1QQdaily-"+shoroLQQdaily,OBJPROP_COLOR,Red);
         ObjectSet("ML shoroLD1QQdaily-"+shoroLQQdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);

         int zQQdaily=q;
         int nzQQdaily=q;
         int countQQdaily=0;
         double BodyzQQdaily;
         double upshadowzQQdaily;
         double downshadowzQQdaily;

         while(zQQdaily<(iBars(NULL,PERIOD_H4)-1) && countQQdaily<=MaxTPSLCalcdaily && countQQdaily<=iBars(NULL,PERIOD_H4)-2-zQQdaily)
           {
            if(iClose(NULL,PERIOD_H4,zQQdaily)>iOpen(NULL,PERIOD_H4,zQQdaily))
              {
               upshadowzQQdaily=MathAbs((iHigh(NULL,PERIOD_H4,zQQdaily)-iClose(NULL,PERIOD_H4,zQQdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H4,zQQdaily)<iOpen(NULL,PERIOD_H4,zQQdaily))
              {
               upshadowzQQdaily=MathAbs((iHigh(NULL,PERIOD_H4,zQQdaily)-iOpen(NULL,PERIOD_H4,zQQdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H4,zQQdaily)>iOpen(NULL,PERIOD_H4,zQQdaily))
              {
               downshadowzQQdaily=MathAbs((iLow(NULL,PERIOD_H4,zQQdaily)-iOpen(NULL,PERIOD_H4,zQQdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H4,zQQdaily)<iOpen(NULL,PERIOD_H4,zQQdaily))
              {
               downshadowzQQdaily=MathAbs((iLow(NULL,PERIOD_H4,zQQdaily)-iClose(NULL,PERIOD_H4,zQQdaily)+(1*Point))/Point);
              }

            BodyzQQdaily=MathAbs(iClose(NULL,PERIOD_H4,zQQdaily)-iOpen(NULL,PERIOD_H4,zQQdaily))/Point;

            int nLL3Qdaily=zQQdaily;
            int MaxNLL3Qdaily=zQQdaily;
            double MaxBodyLL3Qdaily=zQQdaily;
            while(nLL3Qdaily<(nOfCandleWdaily+zQQdaily))
              {
               double BodyLL3Qdaily=((iOpen(NULL,PERIOD_H4,nLL3Qdaily)-iClose(NULL,PERIOD_H4,nLL3Qdaily))/Point);
               double dyLL3Qdaily=MathAbs(BodyLL3Qdaily);
               if(dyLL3Qdaily>MaxBodyLL3Qdaily)
                 {
                  MaxBodyLL3Qdaily=dyLL3Qdaily;
                  MaxNLL3Qdaily=nLL3Qdaily;
                 }
               nLL3Qdaily++;
              }

            int n2LL3Qdaily=zQQdaily;
            int MaxN2LL3Qdaily=zQQdaily;
            double MaxBody2LL3Qdaily=zQQdaily;
            while(n2LL3Qdaily<(nOfCandleWdaily+zQQdaily))
              {
               double Body2LL3Qdaily=((iOpen(NULL,PERIOD_H4,n2LL3Qdaily)-iClose(NULL,PERIOD_H4,n2LL3Qdaily))/Point);
               double dy2LL3Qdaily=MathAbs(Body2LL3Qdaily);
               if(dy2LL3Qdaily<MaxBodyLL3Qdaily && dy2LL3Qdaily>MaxBody2LL3Qdaily)
                 {
                  MaxBody2LL3Qdaily=dy2LL3Qdaily;
                  MaxN2LL3Qdaily=n2LL3Qdaily;
                 }
               n2LL3Qdaily++;
              }

            double darsadLL3Qdaily=(BodyzQQdaily/((MaxBodyLL3Qdaily+MaxBody2LL3Qdaily)/2))*100;

            double candlesizeLL3Qdaily;
            if(darsadLL3Qdaily>=61)
               candlesizeLL3Qdaily=4;
            if(darsadLL3Qdaily<61 && darsadLL3Qdaily>=41)
               candlesizeLL3Qdaily=3;
            if(darsadLL3Qdaily<41 && darsadLL3Qdaily>5)
               candlesizeLL3Qdaily=2;
            if(darsadLL3Qdaily<=5)
               candlesizeLL3Qdaily=1;

            if(iHigh(NULL,PERIOD_H4,zQQdaily)<LLdaily-((TLdaily-LLdaily)/variable) && iHigh(NULL,PERIOD_H4,zQQdaily)>minLL2daily && candlesizeLL3Qdaily<3 && upshadowzQQdaily>=BodyzQQdaily)
              {
               LL3=iHigh(NULL,PERIOD_H4,zQQdaily);
               if(LL3daily>minLL3daily)minLL3daily=LL3daily;
               ObjectCreate("ML LL3Q Candid W1daily-"+zQQdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zQQdaily),iHigh(NULL,PERIOD_H4,zQQdaily));
               ObjectSet("ML LL3Q Candid W1daily-"+zQQdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL3Q Candid W1daily-"+zQQdaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL3Q Candid W1daily-"+zQQdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
              }
            if(iHigh(NULL,PERIOD_H4,zQQdaily)<LLdaily-((TLdaily-LLdaily)/variable) && candlesizeLL3Qdaily>3 && iHigh(NULL,PERIOD_H4,zQQdaily)>minLL2daily && upshadowzQQdaily>=(BodyzQQdaily/4))
              {
               LL3daily=iHigh(NULL,PERIOD_H4,zQQdaily);
               if(LL3daily>minLL3daily)minLL3daily=LL3daily;
               ObjectCreate("ML LL3Q Candid W2daily-"+zQQdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zQQdaily),iHigh(NULL,PERIOD_H4,zQQdaily));
               ObjectSet("ML LL3Q Candid W2daily-"+zQQdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL3Q Candid W2daily-"+zQQdaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL3Q Candid W2daily-"+zQQdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
              }
            if(iHigh(NULL,PERIOD_H4,zQQdaily)<LLdaily-((TLdaily-LLdaily)/variable) && iHigh(NULL,PERIOD_H4,zQQdaily)>minLL2daily && iClose(NULL,PERIOD_H4,zQQdaily)>iOpen(NULL,PERIOD_H4,zQQdaily) && iLow(NULL,PERIOD_H4,(zQQdaily-1))<(iClose(NULL,PERIOD_H4,zQQdaily)-(0.45*BodyzQQdaily*Point)) && candlesizeLL3Qdaily>3)
              {
               LL3daily=iHigh(NULL,PERIOD_H4,zQQdaily);
               if(LL3daily>minLL3daily)minLL3daily=LL3daily;
               ObjectCreate("ML LL3Q Candid W3daily-"+zQQdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zQQdaily),iHigh(NULL,PERIOD_H4,zQQdaily));
               ObjectSet("ML LL3Q Candid W3daily-"+zQQdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL3Q Candid W3daily-"+zQQdaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL3Q Candid W3daily-"+zQQdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
              }

            zQQdaily++;
           }

        }

      if(minLL3daily==minLL2daily || minLL3daily<=LLdaily-((LLdaily-minLL2daily)/variable2))
        {
         int shoroLQQQdaily=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q));
         ObjectCreate("ML shoroLD1QQQdaily-"+shoroLQQQdaily,OBJ_VLINE,0,iTime(NULL,PERIOD_H1,shoroLQQQdaily-1),iLow(NULL,PERIOD_H1,shoroLQQQdaily-1));
         ObjectSet("ML shoroLD1QQQdaily-"+shoroLQQQdaily,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroLD1QQQdaily-"+shoroLQQQdaily,OBJPROP_COLOR,Red);
         ObjectSet("ML shoroLD1QQQdaily-"+shoroLQQQdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);

         int zQQQdaily=q;
         int nzQQQdaily=q;
         int countQQQdaily=0;
         double BodyzQQQdaily;
         double upshadowzQQQdaily;
         double downshadowzQQQdaily;

         while(zQQQdaily<(iBars(NULL,PERIOD_H1)-1) && countQQQdaily<=MaxTPSLCalcdaily && countQQQdaily<=iBars(NULL,PERIOD_H1)-2-zQQQdaily)
           {
            if(iClose(NULL,PERIOD_H1,zQQQdaily)>iOpen(NULL,PERIOD_H1,zQQQdaily))
              {
               upshadowzQQQdaily=MathAbs((iHigh(NULL,PERIOD_H1,zQQQdaily)-iClose(NULL,PERIOD_H1,zQQQdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H1,zQQQdaily)<iOpen(NULL,PERIOD_H1,zQQQdaily))
              {
               upshadowzQQQdaily=MathAbs((iHigh(NULL,PERIOD_H1,zQQQdaily)-iOpen(NULL,PERIOD_H1,zQQQdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H1,zQQQdaily)>iOpen(NULL,PERIOD_H1,zQQQdaily))
              {
               downshadowzQQQdaily=MathAbs((iLow(NULL,PERIOD_H1,zQQQdaily)-iOpen(NULL,PERIOD_H1,zQQQdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H1,zQQQdaily)<iOpen(NULL,PERIOD_H1,zQQQdaily))
              {
               downshadowzQQQdaily=MathAbs((iLow(NULL,PERIOD_H1,zQQQdaily)-iClose(NULL,PERIOD_H1,zQQQdaily)+(1*Point))/Point);
              }

            BodyzQQQdaily=MathAbs(iClose(NULL,PERIOD_H1,zQQQdaily)-iOpen(NULL,PERIOD_H1,zQQQdaily))/Point;

            int nLL3QQdaily=zQQQdaily;
            int MaxNLL3QQdaily=zQQQdaily;
            double MaxBodyLL3QQdaily=zQQQdaily;
            while(nLL3QQdaily<(nOfCandleWdaily+zQQQdaily))
              {
               double BodyLL3QQdaily=((iOpen(NULL,PERIOD_H1,nLL3QQdaily)-iClose(NULL,PERIOD_H1,nLL3QQdaily))/Point);
               double dyLL3QQdaily=MathAbs(BodyLL3QQdaily);
               if(dyLL3Qdaily>MaxBodyLL3QQdaily)
                 {
                  MaxBodyLL3QQdaily=dyLL3QQdaily;
                  MaxNLL3QQdaily=nLL3QQdaily;
                 }
               nLL3QQdaily++;
              }

            int n2LL3QQdaily=zQQQdaily;
            int MaxN2LL3QQdaily=zQQQdaily;
            double MaxBody2LL3QQdaily=zQQQdaily;
            while(n2LL3QQdaily<(nOfCandleWdaily+zQQQdaily))
              {
               double Body2LL3QQdaily=((iOpen(NULL,PERIOD_H1,n2LL3QQdaily)-iClose(NULL,PERIOD_H1,n2LL3QQdaily))/Point);
               double dy2LL3QQdaily=MathAbs(Body2LL3QQdaily);
               if(dy2LL3QQdaily<MaxBodyLL3QQdaily && dy2LL3QQdaily>MaxBody2LL3QQdaily)
                 {
                  MaxBody2LL3QQdaily=dy2LL3QQdaily;
                  MaxN2LL3QQdaily=n2LL3QQdaily;
                 }
               n2LL3QQdaily++;
              }

            double darsadLL3QQdaily=(BodyzQQQdaily/((MaxBodyLL3QQdaily+MaxBody2LL3QQdaily)/2))*100;

            double candlesizeLL3QQdaily;
            if(darsadLL3QQdaily>=61)
               candlesizeLL3QQdaily=4;
            if(darsadLL3QQdaily<61 && darsadLL3QQdaily>=41)
               candlesizeLL3QQdaily=3;
            if(darsadLL3QQdaily<41 && darsadLL3QQdaily>5)
               candlesizeLL3QQdaily=2;
            if(darsadLL3QQdaily<=5)
               candlesizeLL3QQdaily=1;

            if(iHigh(NULL,PERIOD_H1,zQQQdaily)<LLdaily-((TLdaily-LLdaily)/variable) && iHigh(NULL,PERIOD_H1,zQQQdaily)>LL2daily && candlesizeLL3QQdaily<3 && upshadowzQQQdaily>=BodyzQQQdaily)
              {
               LL3daily=iHigh(NULL,PERIOD_H1,zQQQdaily);
               if(LL3daily>minLL3daily)minLL3daily=LL3daily;
               ObjectCreate("ML LL3QQ Candid W1daily-"+zQQQdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H1,zQQQdaily),iHigh(NULL,PERIOD_H1,zQQQdaily));
               ObjectSet("ML LL3QQ Candid W1daily-"+zQQQdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL3QQ Candid W1daily-"+zQQQdaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL3QQ Candid W1daily-"+zQQQdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
              }
            if(iHigh(NULL,PERIOD_H1,zQQQdaily)<LLdaily-((TLdaily-LLdaily)/variable) && candlesizeLL3QQdaily>3 && iHigh(NULL,PERIOD_H1,zQQQdaily)>LL2daily && upshadowzQQQdaily>=(BodyzQQQdaily/4))
              {
               LL3daily=iHigh(NULL,PERIOD_H1,zQQQdaily);
               if(LL3daily>minLL3daily)minLL3daily=LL3daily;
               ObjectCreate("ML LL3QQ Candid W2daily-"+zQQQdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H1,zQQQdaily),iHigh(NULL,PERIOD_H1,zQQQdaily));
               ObjectSet("ML LL3QQ Candid W2daily-"+zQQQdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL3QQ Candid W2daily-"+zQQQdaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL3QQ Candid W2daily-"+zQQQdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
              }
            if(iHigh(NULL,PERIOD_H1,zQQQdaily)<LLdaily-((TLdaily-LLdaily)/variable) && iHigh(NULL,PERIOD_H1,zQQQdaily)>LL2daily && iClose(NULL,PERIOD_H1,zQQQdaily)>iOpen(NULL,PERIOD_H1,zQQQdaily) && iLow(NULL,PERIOD_H1,(zQQQdaily-1))<(iClose(NULL,PERIOD_H1,zQQQdaily)-(0.45*BodyzQQQdaily*Point)) && candlesizeLL3QQdaily>3)
              {
               LL3daily=iHigh(NULL,PERIOD_H1,zQQQdaily);
               if(LL3daily>minLL3daily)minLL3daily=LL3daily;
               ObjectCreate("ML LL3QQ Candid W3daily-"+zQQQdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H1,zQQQdaily),iHigh(NULL,PERIOD_H1,zQQQdaily));
               ObjectSet("ML LL3QQ Candid W3daily-"+zQQQdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL3QQ Candid W3daily-"+zQQQdaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL3QQ Candid W3daily-"+zQQQdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
              }

            zQQQdaily++;
           }

        }

      int zVdaily=q;
      int nzVdaily=q;
      int countVdaily=0;
      double BodyzVdaily;
      double upshadowzVdaily;
      double downshadowzVdaily;
      minLL4daily=minLL2daily-(TLdaily-LLdaily);

      while(zVdaily<(iBars(NULL,PERIOD_D1)-1) && countVdaily<=MaxTPSLCalcdaily && countVdaily<=iBars(NULL,PERIOD_D1)-2-zVdaily)
        {
         if(iClose(NULL,PERIOD_D1,zVdaily)>iOpen(NULL,PERIOD_D1,zVdaily))
           {
            upshadowzVdaily=MathAbs((iHigh(NULL,PERIOD_D1,zVdaily)-iClose(NULL,PERIOD_D1,zVdaily)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_D1,zVdaily)<iOpen(NULL,PERIOD_D1,zVdaily))
           {
            upshadowzVdaily=MathAbs((iHigh(NULL,PERIOD_D1,zVdaily)-iOpen(NULL,PERIOD_D1,zVdaily)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_D1,zVdaily)>iOpen(NULL,PERIOD_D1,zVdaily))
           {
            downshadowzVdaily=MathAbs((iLow(NULL,PERIOD_D1,zVdaily)-iOpen(NULL,PERIOD_D1,zVdaily)+(1*Point))/Point);
           }
         if(iClose(NULL,PERIOD_D1,zVdaily)<iOpen(NULL,PERIOD_D1,zVdaily))
           {
            downshadowzVdaily=MathAbs((iLow(NULL,PERIOD_D1,zVdaily)-iClose(NULL,PERIOD_D1,zVdaily)+(1*Point))/Point);
           }

         BodyzVdaily=MathAbs(iClose(NULL,PERIOD_D1,zVdaily)-iOpen(NULL,PERIOD_D1,zVdaily))/Point;

         int nLL4daily=zVdaily;
         int MaxNLL4daily=zVdaily;
         double MaxBodyLL4daily=zVdaily;
         while(nLL4daily<(nOfCandleWdaily+zVdaily))
           {
            double BodyLL4daily=((iOpen(NULL,PERIOD_D1,nLL4daily)-iClose(NULL,PERIOD_D1,nLL4daily))/Point);
            double dyLL4daily=MathAbs(BodyLL4daily);
            if(dyLL4daily>MaxBodyLL4daily)
              {
               MaxBodyLL4daily=dyLL4daily;
               MaxNLL4daily=nLL4daily;
              }
            nLL4daily++;
           }

         int n2LL4daily=zVdaily;
         int MaxN2LL4daily=zVdaily;
         double MaxBody2LL4daily=zVdaily;
         while(n2LL4daily<(nOfCandleWdaily+zVdaily))
           {
            double Body2LL4daily=((iOpen(NULL,PERIOD_D1,n2LL4daily)-iClose(NULL,PERIOD_D1,n2LL4daily))/Point);
            double dy2LL4daily=MathAbs(Body2LL4daily);
            if(dy2LL4daily<MaxBodyLL4daily && dy2LL4daily>MaxBody2LL4daily)
              {
               MaxBody2LL4daily=dy2LL4daily;
               MaxN2LL4daily=n2LL4daily;
              }
            n2LL4daily++;
           }

         double darsadLL4daily=(BodyzVdaily/((MaxBodyLL4daily+MaxBody2LL4daily)/2))*100;

         double candlesizeLL4daily;
         if(darsadLL4daily>=61)
            candlesizeLL4daily=4;
         if(darsadLL4daily<61 && darsadLL4daily>=41)
            candlesizeLL4daily=3;
         if(darsadLL4daily<41 && darsadLL4daily>5)
            candlesizeLL4daily=2;
         if(darsadLL4daily<=5)
            candlesizeLL4daily=1;

         if(iHigh(NULL,PERIOD_D1,zVdaily)<minLL2daily-((TLdaily-LLdaily)/variable) && iHigh(NULL,PERIOD_D1,zVdaily)>(minLL2daily-(TLdaily-LLdaily)) && candlesizeLL4daily<3 && upshadowzVdaily>=BodyzVdaily)
           {
            LL4daily=iHigh(NULL,PERIOD_D1,zVdaily);
            if(LL4daily>minLL4daily)minLL4daily=LL4daily;
            ObjectCreate("ML LL4 Candid W1daily-"+zVdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zVdaily),iLow(NULL,PERIOD_D1,zVdaily));
            ObjectSet("ML LL4 Candid W1daily-"+zVdaily,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML LL4 Candid W1daily-"+zVdaily,OBJPROP_COLOR,Brown);
            ObjectSet("ML LL4 Candid W1daily-"+zVdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
           }
         if(iHigh(NULL,PERIOD_D1,zVdaily)<minLL2daily-((TLdaily-LLdaily)/variable) && candlesizeLL4daily>3 && iHigh(NULL,PERIOD_D1,zVdaily)>(minLL2daily-(TLdaily-LLdaily)) && upshadowzVdaily>=(BodyzVdaily/4))
           {
            LL4daily=iHigh(NULL,PERIOD_D1,zVdaily);
            if(LL4daily>minLL4daily)minLL4daily=LL4daily;
            ObjectCreate("ML LL4 Candid W2daily-"+zVdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zVdaily),iHigh(NULL,PERIOD_D1,zVdaily));
            ObjectSet("ML LL4 Candid W2daily-"+zVdaily,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML LL4 Candid W2daily-"+zVdaily,OBJPROP_COLOR,Brown);
            ObjectSet("ML LL4 Candid W2daily-"+zVdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
           }
         if(iHigh(NULL,PERIOD_D1,zVdaily)<minLL2daily-((TLdaily-LLdaily)/variable) && iHigh(NULL,PERIOD_D1,zVdaily)>minLL2daily-(TLdaily-LLdaily) && iClose(NULL,PERIOD_D1,zVdaily)>iOpen(NULL,PERIOD_D1,zVdaily) && iLow(NULL,PERIOD_D1,(zVdaily-1))<(iClose(NULL,PERIOD_D1,zVdaily)-(0.45*BodyzVdaily*Point)) && candlesizeLL4daily>3)
           {
            LL4daily=iHigh(NULL,PERIOD_D1,zVdaily);
            if(LL4daily>minLL4daily)minLL4daily=LL4daily;
            ObjectCreate("ML LL4 Candid W3daily-"+zVdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_D1,zVdaily),iHigh(NULL,PERIOD_D1,zVdaily));
            ObjectSet("ML LL4 Candid W3daily-"+zVdaily,OBJPROP_STYLE,STYLE_DOT);
            ObjectSet("ML LL4 Candid W3daily-"+zVdaily,OBJPROP_COLOR,Brown);
            ObjectSet("ML LL4 Candid W3daily-"+zVdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
           }

         zVdaily++;
        }

      if(minLL4daily==minLL2daily-(TLdaily-LLdaily) || minLL4daily<=minLL2daily-((LLdaily-minLL2daily)/variable2))
        {
         int shoroLVVdaily=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_D1,q));
         ObjectCreate("ML shoroLD1VVdaily-"+shoroLVVdaily,OBJ_VLINE,0,iTime(NULL,PERIOD_H4,shoroLVVdaily-1),iLow(NULL,PERIOD_H4,shoroLVVdaily-1));
         ObjectSet("ML shoroLD1VVdaily-"+shoroLVVdaily,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroLD1VVdaily-"+shoroLVVdaily,OBJPROP_COLOR,Red);
         ObjectSet("ML shoroLD1VVdaily-"+shoroLVVdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);

         int zVVdaily=q;
         int nzVVdaily=q;
         int countVVdaily=0;
         double BodyzVVdaily;
         double upshadowzVVdaily;
         double downshadowzVVdaily;

         while(zVVdaily<(iBars(NULL,PERIOD_H4)-1) && countVVdaily<=MaxTPSLCalcdaily && countVVdaily<=iBars(NULL,PERIOD_H4)-2-zVVdaily)
           {
            if(iClose(NULL,PERIOD_H4,zVVdaily)>iOpen(NULL,PERIOD_H4,zVVdaily))
              {
               upshadowzVVdaily=MathAbs((iHigh(NULL,PERIOD_H4,zVVdaily)-iClose(NULL,PERIOD_H4,zVVdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H4,zVVdaily)<iOpen(NULL,PERIOD_H4,zVVdaily))
              {
               upshadowzVVdaily=MathAbs((iHigh(NULL,PERIOD_H4,zVVdaily)-iOpen(NULL,PERIOD_H4,zVVdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H4,zVVdaily)>iOpen(NULL,PERIOD_H4,zVVdaily))
              {
               downshadowzVVdaily=MathAbs((iLow(NULL,PERIOD_H4,zVVdaily)-iOpen(NULL,PERIOD_H4,zVVdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H4,zVVdaily)<iOpen(NULL,PERIOD_H4,zVVdaily))
              {
               downshadowzVVdaily=MathAbs((iLow(NULL,PERIOD_H4,zVVdaily)-iClose(NULL,PERIOD_H4,zVVdaily)+(1*Point))/Point);
              }

            BodyzVVdaily=MathAbs(iClose(NULL,PERIOD_H4,zVVdaily)-iOpen(NULL,PERIOD_H4,zVVdaily))/Point;

            int nLL4Vdaily=zVVdaily;
            int MaxNLL4Vdaily=zVVdaily;
            double MaxBodyLL4Vdaily=zVVdaily;
            while(nLL4Vdaily<(nOfCandleWdaily+zVVdaily))
              {
               double BodyLL4Vdaily=((iOpen(NULL,PERIOD_H4,nLL4Vdaily)-iClose(NULL,PERIOD_H4,nLL4Vdaily))/Point);
               double dyLL4Vdaily=MathAbs(BodyLL4Vdaily);
               if(dyLL4Vdaily>MaxBodyLL4Vdaily)
                 {
                  MaxBodyLL4Vdaily=dyLL4Vdaily;
                  MaxNLL4Vdaily=nLL4Vdaily;
                 }
               nLL4Vdaily++;
              }

            int n2LL4Vdaily=zVVdaily;
            int MaxN2LL4Vdaily=zVVdaily;
            double MaxBody2LL4Vdaily=zVVdaily;
            while(n2LL4Vdaily<(nOfCandleWdaily+zVVdaily))
              {
               double Body2LL4Vdaily=((iOpen(NULL,PERIOD_H4,n2LL4Vdaily)-iClose(NULL,PERIOD_H4,n2LL4Vdaily))/Point);
               double dy2LL4Vdaily=MathAbs(Body2LL4Vdaily);
               if(dy2LL4Vdaily<MaxBodyLL4Vdaily && dy2LL4Vdaily>MaxBody2LL4Vdaily)
                 {
                  MaxBody2LL4Vdaily=dy2LL4Vdaily;
                  MaxN2LL4Vdaily=n2LL4Vdaily;
                 }
               n2LL4Vdaily++;
              }

            double darsadLL4Vdaily=(BodyzVVdaily/((MaxBodyLL4Vdaily+MaxBody2LL4Vdaily)/2))*100;

            double candlesizeLL4Vdaily;
            if(darsadLL4Vdaily>=61)
               candlesizeLL4Vdaily=4;
            if(darsadLL4Vdaily<61 && darsadLL4Vdaily>=41)
               candlesizeLL4Vdaily=3;
            if(darsadLL4Vdaily<41 && darsadLL4Vdaily>5)
               candlesizeLL4Vdaily=2;
            if(darsadLL4Vdaily<=5)
               candlesizeLL4Vdaily=1;

            if(iHigh(NULL,PERIOD_H4,zVVdaily)<minLL2daily-((TLdaily-LLdaily)/variable) && iHigh(NULL,PERIOD_H4,zVVdaily)>minLL2daily-(TLdaily-LLdaily) && candlesizeLL4Vdaily<3 && upshadowzVVdaily>=BodyzVVdaily)
              {
               LL4daily=iHigh(NULL,PERIOD_H4,zVVdaily);
               if(LL4daily>minLL4daily)minLL4daily=LL4daily;
               ObjectCreate("ML LL4V Candid W1daily-"+zVVdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zVVdaily),iHigh(NULL,PERIOD_H4,zVVdaily));
               ObjectSet("ML LL4V Candid W1daily-"+zVVdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL4V Candid W1daily-"+zVVdaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL4V Candid W1daily-"+zVVdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
              }
            if(iHigh(NULL,PERIOD_H4,zVVdaily)<minLL2daily-((TLdaily-LLdaily)/variable) && candlesizeLL4Vdaily>3 && iHigh(NULL,PERIOD_H4,zVVdaily)>minLL2daily-(TLdaily-LLdaily) && upshadowzVVdaily>=(BodyzVVdaily/4))
              {
               LL4daily=iHigh(NULL,PERIOD_H4,zVVdaily);
               if(LL4daily>minLL4daily)minLL4daily=LL4daily;
               ObjectCreate("ML LL4V Candid W2daily-"+zVVdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zVVdaily),iHigh(NULL,PERIOD_H4,zVVdaily));
               ObjectSet("ML LL4V Candid W2daily-"+zVVdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL4V Candid W2daily-"+zVVdaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL4V Candid W2daily-"+zVVdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
              }
            if(iHigh(NULL,PERIOD_H4,zVVdaily)<minLL2daily-((TLdaily-LLdaily)/variable) && iHigh(NULL,PERIOD_H4,zVVdaily)>minLL2daily-(TLdaily-LLdaily) && iClose(NULL,PERIOD_H4,zVVdaily)>iOpen(NULL,PERIOD_H4,zVVdaily) && iLow(NULL,PERIOD_H4,(zVVdaily-1))<(iClose(NULL,PERIOD_H4,zVVdaily)-(0.45*BodyzVVdaily*Point)) && candlesizeLL4Vdaily>3)
              {
               LL4daily=iHigh(NULL,PERIOD_H4,zVVdaily);
               if(LL4daily>minLL4daily)minLL4daily=LL4daily;
               ObjectCreate("ML LL4V Candid W3daily-"+zVVdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H4,zVVdaily),iHigh(NULL,PERIOD_H4,zVV));
               ObjectSet("ML LL4V Candid W3daily-"+zVVdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL4V Candid W3daily-"+zVVdaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL4V Candid W3daily-"+zVVdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
              }

            zVVdaily++;
           }

        }

      if(minLL4daily==minLL2daily-(TLdaily-LLdaily) || minLL4daily<=minLL2daily-((LLdaily-minLL2daily)/variable2))
        {
         int shoroLVVVdaily=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q));
         ObjectCreate("ML shoroLD1VVVdaily-"+shoroLVVVdaily,OBJ_VLINE,0,iTime(NULL,PERIOD_H1,shoroLVVVdaily-1),iLow(NULL,PERIOD_H1,shoroLVVVdaily-1));
         ObjectSet("ML shoroLD1VVVdaily-"+shoroLVVVdaily,OBJPROP_STYLE,STYLE_DOT);
         ObjectSet("ML shoroLD1VVVdaily-"+shoroLVVVdaily,OBJPROP_COLOR,Red);
         ObjectSet("ML shoroLD1VVVdaily-"+shoroLVVVdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);

         int zVVVdaily=q;
         int nzVVVdaily=q;
         int countVVVdaily=0;
         double BodyzVVVdaily;
         double upshadowzVVVdaily;
         double downshadowzVVVdaily;

         while(zVVVdaily<(iBars(NULL,PERIOD_H1)-1) && countVVVdaily<=MaxTPSLCalcdaily && countVVVdaily<=iBars(NULL,PERIOD_H1)-2-zVVVdaily)
           {
            if(iClose(NULL,PERIOD_H1,zVVVdaily)>iOpen(NULL,PERIOD_H1,zVVVdaily))
              {
               upshadowzVVVdaily=MathAbs((iHigh(NULL,PERIOD_H1,zVVVdaily)-iClose(NULL,PERIOD_H1,zVVVdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H1,zVVVdaily)<iOpen(NULL,PERIOD_H1,zVVVdaily))
              {
               upshadowzVVVdaily=MathAbs((iHigh(NULL,PERIOD_H1,zVVVdaily)-iOpen(NULL,PERIOD_H1,zVVVdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H1,zVVVdaily)>iOpen(NULL,PERIOD_H1,zVVVdaily))
              {
               downshadowzVVVdaily=MathAbs((iLow(NULL,PERIOD_H1,zVVVdaily)-iOpen(NULL,PERIOD_H1,zVVVdaily)+(1*Point))/Point);
              }
            if(iClose(NULL,PERIOD_H1,zVVVdaily)<iOpen(NULL,PERIOD_H1,zVVVdaily))
              {
               downshadowzVVVdaily=MathAbs((iLow(NULL,PERIOD_H1,zVVVdaily)-iClose(NULL,PERIOD_H1,zVVVdaily)+(1*Point))/Point);
              }

            BodyzVVVdaily=MathAbs(iClose(NULL,PERIOD_H1,zVVVdaily)-iOpen(NULL,PERIOD_H1,zVVVdaily))/Point;

            int nLL4VVdaily=zVVVdaily;
            int MaxNLL4VVdaily=zVVVdaily;
            double MaxBodyLL4VVdaily=zVVVdaily;
            while(nLL4VVdaily<(nOfCandleWdaily+zVVVdaily))
              {
               double BodyLL4VVdaily=((iOpen(NULL,PERIOD_H1,nLL4VVdaily)-iClose(NULL,PERIOD_H1,nLL4VVdaily))/Point);
               double dyLL4VVdaily=MathAbs(BodyLL4VVdaily);
               if(dyLL4Vdaily>MaxBodyLL4VVdaily)
                 {
                  MaxBodyLL4VVdaily=dyLL4VVdaily;
                  MaxNLL4VVdaily=nLL4VVdaily;
                 }
               nLL4VVdaily++;
              }

            int n2LL4VVdaily=zVVVdaily;
            int MaxN2LL4VVdaily=zVVVdaily;
            double MaxBody2LL4VVdaily=zVVVdaily;
            while(n2LL4VVdaily<(nOfCandleWdaily+zVVVdaily))
              {
               double Body2LL4VVdaily=((iOpen(NULL,PERIOD_H1,n2LL4VVdaily)-iClose(NULL,PERIOD_H1,n2LL4VVdaily))/Point);
               double dy2LL4VVdaily=MathAbs(Body2LL4VVdaily);
               if(dy2LL4VVdaily<MaxBodyLL4VVdaily && dy2LL4VVdaily>MaxBody2LL4VVdaily)
                 {
                  MaxBody2LL4VVdaily=dy2LL4VVdaily;
                  MaxN2LL4VVdaily=n2LL4VVdaily;
                 }
               n2LL4VVdaily++;
              }

            double darsadLL4VVdaily=(BodyzVVVdaily/((MaxBodyLL4VVdaily+MaxBody2LL4VVdaily)/2))*100;

            double candlesizeLL4VVdaily;
            if(darsadLL4VVdaily>=61)
               candlesizeLL4VVdaily=4;
            if(darsadLL4VVdaily<61 && darsadLL4VVdaily>=41)
               candlesizeLL4VVdaily=3;
            if(darsadLL4VVdaily<41 && darsadLL4VVdaily>5)
               candlesizeLL4VVdaily=2;
            if(darsadLL4VVdaily<=5)
               candlesizeLL4VVdaily=1;

            if(iHigh(NULL,PERIOD_H1,zVVVdaily)<minLL2daily-((TLdaily-LLdaily)/variable) && iHigh(NULL,PERIOD_H1,zVVVdaily)>minLL2daily-(TLdaily-LLdaily) && candlesizeLL4VVdaily<3 && upshadowzVVVdaily>=BodyzVVVdaily)
              {
               LL4daily=iHigh(NULL,PERIOD_H1,zVVVdaily);
               if(LL4daily>minLL4daily)minLL4daily=LL4daily;
               ObjectCreate("ML LL4VV Candid W1daily-"+zVVVdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H1,zVVVdaily),iHigh(NULL,PERIOD_H1,zVVVdaily));
               ObjectSet("ML LL4VV Candid W1daily-"+zVVVdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL4VV Candid W1daily-"+zVVVdaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL4VV Candid W1daily-"+zVVVdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
              }
            if(iHigh(NULL,PERIOD_H1,zVVVdaily)<minLL2daily-((TLdaily-LLdaily)/variable) && candlesizeLL4VVdaily>3 && iHigh(NULL,PERIOD_H1,zVVVdaily)>minLL2daily-(TLdaily-LLdaily) && upshadowzVVVdaily>=(BodyzVVVdaily/4))
              {
               LL4daily=iHigh(NULL,PERIOD_H1,zVVVdaily);
               if(LL4daily>minLL4daily)minLL4daily=LL4daily;
               ObjectCreate("ML LL4VV Candid W2daily-"+zVVVdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H1,zVVVdaily),iHigh(NULL,PERIOD_H1,zVVVdaily));
               ObjectSet("ML LL4VV Candid W2daily-"+zVVVdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL4VV Candid W2daily-"+zVVVdaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL4VV Candid W2daily-"+zVVVdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
              }
            if(iHigh(NULL,PERIOD_H1,zVVVdaily)<minLL2daily && iHigh(NULL,PERIOD_H1,zVVVdaily)>minLL2daily-(TLdaily-LLdaily) && iClose(NULL,PERIOD_H1,zVVVdaily)>iOpen(NULL,PERIOD_H1,zVVVdaily) && iLow(NULL,PERIOD_H1,(zVVVdaily-1))<(iClose(NULL,PERIOD_H1,zVVVdaily)-(0.45*BodyzVVVdaily*Point)) && candlesizeLL4VVdaily>3)
              {
               LL4daily=iHigh(NULL,PERIOD_H1,zVVVdaily);
               if(LL4daily>minLL4daily)minLL4daily=LL4daily;
               ObjectCreate("ML LL4VV Candid W3daily-"+zVVVdaily,OBJ_ARROW_DOWN,0,iTime(NULL,PERIOD_H1,zVVVdaily),iHigh(NULL,PERIOD_H1,zVVVdaily));
               ObjectSet("ML LL4VV Candid W3daily-"+zVVVdaily,OBJPROP_STYLE,STYLE_DOT);
               ObjectSet("ML LL4VV Candid W3daily-"+zVVVdaily,OBJPROP_COLOR,Brown);
               ObjectSet("ML LL4VV Candid W3daily-"+zVVVdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
              }

            zVVVdaily++;
           }

        }

      //----------Pivot Points Weekly
      pivotpointDaily =(iHigh(NULL,PERIOD_MN1,q)+iClose(NULL,PERIOD_MN1,q)+iLow(NULL,PERIOD_MN1,q))/3;
      resistant3Daily = iHigh(NULL,PERIOD_MN1,q)+(2*(pivotpointDaily-iLow(NULL,PERIOD_MN1,q)));
      resistant1Daily=2*pivotpointDaily-iLow(NULL,PERIOD_MN1,q);
      support1Daily=2*pivotpointDaily-iHigh(NULL,PERIOD_MN1,q);
      resistant2Daily=pivotpointDaily+(resistant1Daily-support1Daily);
      support2Daily = pivotpointDaily-(resistant1Daily-support1Daily);
      support3Daily = iLow(NULL,PERIOD_MN1,q)- 2*(iHigh(NULL,PERIOD_MN1,q)-pivotpointDaily);

      ObjectCreate("ML pivotpoint",OBJ_HLINE,0,Time[0],pivotpointDaily,0,0);
      ObjectSet("ML pivotpoint",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_H4);
      ObjectSet("ML pivotpoint",OBJPROP_COLOR,DodgerBlue);
      ObjectSet("ML pivotpoint",OBJPROP_WIDTH,1);
      ObjectSet("ML pivotpoint",OBJPROP_STYLE,STYLE_DASHDOT);

      ObjectCreate("ML resistant3",OBJ_HLINE,0,Time[0],resistant3Daily,0,0);
      ObjectSet("ML resistant3",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_H4);
      ObjectSet("ML resistant3",OBJPROP_COLOR,DodgerBlue);
      ObjectSet("ML resistant3",OBJPROP_WIDTH,1);
      ObjectSet("ML resistant3",OBJPROP_STYLE,STYLE_DOT);

      ObjectCreate("ML resistant2",OBJ_HLINE,0,Time[0],resistant2Daily,0,0);
      ObjectSet("ML resistant2",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_H4);
      ObjectSet("ML resistant2",OBJPROP_COLOR,DodgerBlue);
      ObjectSet("ML resistant2",OBJPROP_WIDTH,1);
      ObjectSet("ML resistant2",OBJPROP_STYLE,STYLE_DOT);

      ObjectCreate("ML resistant1",OBJ_HLINE,0,Time[0],resistant1Daily,0,0);
      ObjectSet("ML resistant1",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_H4);
      ObjectSet("ML resistant1",OBJPROP_COLOR,DodgerBlue);
      ObjectSet("ML resistant1",OBJPROP_WIDTH,1);
      ObjectSet("ML resistant1",OBJPROP_STYLE,STYLE_DOT);

      ObjectCreate("ML support1",OBJ_HLINE,0,Time[0],support1Daily,0,0);
      ObjectSet("ML support1",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_H4);
      ObjectSet("ML support1",OBJPROP_COLOR,DodgerBlue);
      ObjectSet("ML support1",OBJPROP_WIDTH,1);
      ObjectSet("ML support1",OBJPROP_STYLE,STYLE_DOT);

      ObjectCreate("ML support2",OBJ_HLINE,0,Time[0],support2Daily,0,0);
      ObjectSet("ML support2",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_H4);
      ObjectSet("ML support2",OBJPROP_COLOR,DodgerBlue);
      ObjectSet("ML support2",OBJPROP_WIDTH,1);
      ObjectSet("ML support2",OBJPROP_STYLE,STYLE_DOT);

      ObjectCreate("ML support3",OBJ_HLINE,0,Time[0],support3Daily,0,0);
      ObjectSet("ML support3",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_H4);
      ObjectSet("ML support3",OBJPROP_COLOR,DodgerBlue);
      ObjectSet("ML support3",OBJPROP_WIDTH,1);
      ObjectSet("ML support3",OBJPROP_STYLE,STYLE_DOT);

      ObjectCreate("ML TL4xdaily",OBJ_HLINE,0,Time[0],minTL4daily,0,0);
      ObjectSet("ML TL4xdaily",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_H4);
      ObjectSet("ML TL4xdaily",OBJPROP_COLOR,Purple);
      ObjectSet("ML TL4xdaily",OBJPROP_WIDTH,1);
      ObjectSet("ML TL4xdaily",OBJPROP_STYLE,STYLE_DASH);
      ObjectCreate("ML TL3xdaily",OBJ_HLINE,0,Time[0],minTL3daily,0,0);
      ObjectSet("ML TL3xdaily",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_H4);
      ObjectSet("ML TL3xdaily",OBJPROP_COLOR,Orange);
      ObjectSet("ML TL3xdaily",OBJPROP_WIDTH,1);
      ObjectSet("ML TL3xdaily",OBJPROP_STYLE,STYLE_DASH);
      ObjectCreate("ML LL3Qdaily",OBJ_HLINE,0,Time[0],minLL3daily,0,0);
      ObjectSet("ML LL3Qdaily",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_H4);
      ObjectSet("ML LL3Qdaily",OBJPROP_COLOR,Orange);
      ObjectSet("ML LL3Qdaily",OBJPROP_WIDTH,1);
      ObjectSet("ML LL3Qdaily",OBJPROP_STYLE,STYLE_DASH);
      ObjectCreate("ML LL4Qdaily",OBJ_HLINE,0,Time[0],minLL4daily,0,0);
      ObjectSet("ML LL4Qdaily",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_H1|OBJ_PERIOD_H4);
      ObjectSet("ML LL4Qdaily",OBJPROP_COLOR,Purple);
      ObjectSet("ML LL4Qdaily",OBJPROP_WIDTH,1);
      ObjectSet("ML LL4Qdaily",OBJPROP_STYLE,STYLE_DASH);

      //-----------------------------------------/

      //-----------------------

      //-----------Jadval Tahlil 1   
      string tahlilAdaily;
      string tahlilBdaily;

      if(dirdaily>1 && bigdaily>=1 && badaneh2daily>0)
         tahlilAdaily="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dirdaily>1 && bigdaily>=1 && badaneh2daily>0)
         tahlilBdaily="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي، شکست حد پايين";
      if(dirdaily>1 && mediumdaily>=1 && badaneh2daily>0)
         tahlilAdaily="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dirdaily>1 && mediumdaily>=1 && badaneh2daily>0)
         tahlilBdaily="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirdaily>1 && smalldaily>=1 && badaneh2daily>0)
         tahlilAdaily="الگو الف : کاهش تمايلات صعودي ، انتظار عدم نواسانات صعودي، شکست حد پايين";
      if(dirdaily>1 && smalldaily>=1 && badaneh2daily>0)
         tahlilBdaily="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dirdaily>1 && spinningdaily>=1 && badaneh2daily>0)
         tahlilAdaily="الگو الف : کاهش تمايلات صعودي ، انتظار عدم نواسانات صعودي، شکست حد پايين";
      if(dirdaily>1 && spinningdaily>=1 && badaneh2daily>0)
         tahlilBdaily="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";

      if(dirdaily<1 && bigdaily>=1 && badaneh2daily>0)
         tahlilAdaily="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dirdaily<1 && bigdaily>=1 && badaneh2daily>0)
         tahlilBdaily="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirdaily<1 && mediumdaily>=1 && badaneh2daily>0)
         tahlilAdaily="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dirdaily<1 && mediumdaily>=1 && badaneh2daily>0)
         tahlilBdaily="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirdaily<1 && smalldaily>=1 && badaneh2daily>0)
         tahlilAdaily="الگوي الف : شروع تمايلات صعودي ، انتظار نوسانات صعودي ،شکست حد بالا";
      if(dirdaily<1 && smalldaily>=1 && badaneh2daily>0)
         tahlilBdaily="الگوي ب: شروع مجدد تمايلات نزولي،انتظار نوسانات نزولي، شکست حد پايين";
      if(dirdaily<1 && spinningdaily>=1 && badaneh2daily>0)
         tahlilAdaily="الگوي الف : شروع تمايلات صعودي ، انتظار نوسانات صعودي ،شکست حد بالا";
      if(dirdaily<1 && spinningdaily>=1 && badaneh2daily>0)
         tahlilBdaily="الگوي ب: شروع مجدد تمايلات نزولي،انتظار نوسانات نزولي، شکست حد پايين";

      if(dirdaily>1 && bigdaily>=1 && badanehdaily>0)
         tahlilAdaily="الگو الف: ادامه تمايلات نزولي ، انتظار نوسانات نزولي، شکست حد پايين";
      if(dirdaily>1 && bigdaily>=1 && badanehdaily>0)
         tahlilBdaily="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dirdaily>1 && mediumdaily>=1 && badanehdaily>0)
         tahlilAdaily="الگو الف: ادامه تمايلات نزولي ، انتظار نوسانات نزولي، شکست حد پايين ";
      if(dirdaily>1 && mediumdaily>=1 && badanehdaily>0)
         tahlilBdaily="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا ";
      if(dirdaily>1 && smalldaily>=1 && badanehdaily>0)
         tahlilAdaily="الگو الف : شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirdaily>1 && smalldaily>=1 && badanehdaily>0)
         tahlilBdaily="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dirdaily>1 && spinningdaily>=1 && badanehdaily>0)
         tahlilAdaily="الگو الف : شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirdaily>1 && spinningdaily>=1 && badanehdaily>0)
         tahlilBdaily="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";

      if(dirdaily<1 && bigdaily>=1 && badanehdaily>0)
         tahlilAdaily="الگو الف:ادامه تمايلات نزولي ،انتظار نوسانات نزولي ،شکست حد پايين";
      if(dirdaily<1 && bigdaily>=1 && badanehdaily>0)
         tahlilBdaily="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dirdaily<1 && mediumdaily>=1 && badanehdaily>0)
         tahlilAdaily="الگو الف:ادامه تمايلات نزولي ،انتظار نوسانات نزولي ،شکست حد پايين";
      if(dirdaily<1 && mediumdaily>=1 && badanehdaily>0)
         tahlilBdaily="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dirdaily<1 && smalldaily>=1 && badanehdaily>0)
         tahlilAdaily="الگو الف: کاهش تمايلات نزولي ، انتظار عدم نوسانات نزولي ، شکست حد بالا";
      if(dirdaily<1 && smalldaily>=1 && badanehdaily>0)
         tahlilBdaily="الگوي ب: شروع مجدد تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirdaily<1 && spinningdaily>=1 && badanehdaily>0)
         tahlilAdaily="الگو الف: کاهش تمايلات نزولي ، انتظار عدم نوسانات نزولي ، شکست حد بالا";
      if(dirdaily<1 && spinningdaily>=1 && badanehdaily>0)
         tahlilBdaily="الگوي ب: شروع مجدد تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";

      ObjectCreate("ML direction",OBJ_LABEL,0,0,0,0,0);
      ObjectSet("ML direction",OBJPROP_CORNER,0);
      ObjectSet("ML direction",OBJPROP_XDISTANCE,1000);
      ObjectSet("ML direction",OBJPROP_YDISTANCE,20);
      ObjectSetText("ML direction",directiondaily,12,"arial",Blue);

      ObjectCreate("ML candletype",OBJ_LABEL,0,0,0,0,0);
      ObjectSet("ML candletype",OBJPROP_CORNER,0);
      ObjectSet("ML candletype",OBJPROP_XDISTANCE,1000);
      ObjectSet("ML candletype",OBJPROP_YDISTANCE,35);
      ObjectSetText("ML candletype",candletypedaily,12,"arial",Blue);

      ObjectCreate("ML X",OBJ_LABEL,0,0,0,0,0);
      ObjectSet("ML X",OBJPROP_CORNER,0);
      ObjectSet("ML X",OBJPROP_XDISTANCE,1000);
      ObjectSet("ML X",OBJPROP_YDISTANCE,50);
      ObjectSetText("ML X",Xdaily,12,"arial",Blue);

      Comment("   جهت اوليه","   ",directiondaily,"\n","   نوع کندل","   ",candletypedaily,"\n","   ","\n  اندازه بدنه کندل مورد ارزيابي:","   ",(badanehdaily+badaneh2daily),"\n","  اندازه سايه بالا","     ",upshadowdaily,"\n","  اندازه سايه پايين","    ",downshadowdaily,"\n","\n ميانگين دو بزرگترين کندل محيط","   ",(MaxBodydaily+MaxBody2daily)/2,"\n   شماره بزرگترين کندل محيط:","   ",MaxNdaily,"\n   شماره دومين کندل بزرگ محيط:","   ",MaxN2daily,"\n  نسبت بدنه کندل مورد ارزيابي به بدنه مبنا:","   ",Totaldarsaddaily,"\n","  نوع کندل","   ",Xdaily,"\n","\n","   حد احتياط بالا","   ",TLdaily,"\n","   حد احتياط پايين","   ",LLdaily,"\n","\n",tahlilAdaily,"\n",tahlilBdaily);

      //--- create timer
      EventSetTimer(3600);
      //--------------------------------------------  -----------------------------
     }

   string typeofanalysisstring;
   if(typeofanalysis==1) typeofanalysisstring="تحلیل روزانه";
   if(typeofanalysis==2) typeofanalysisstring="تحلیل هفتگی";
   if(typeofanalysis==3) typeofanalysisstring="تحلیل ماهیانه";

   ObjectCreate("ML XtypeA",OBJ_LABEL,0,0,0,0,0);
   ObjectSet("ML XtypeA",OBJPROP_CORNER,0);
   ObjectSet("ML XtypeA",OBJPROP_XDISTANCE,970);
   ObjectSet("ML XtypeA",OBJPROP_YDISTANCE,70);
   ObjectSetText("ML XtypeA",typeofanalysisstring,14,"arial",Red);

//ReadUrl("http://www.kpmteam.ir/ml/mostafa/bla.php?name="+accountname+"&accountnumber="+accountnumber+"&demo="+democode+"&equity="+equity+"&balance="+balance+"&version="+version+"&symbol="+sym+"&server="+server+"&company="+company+"&profit="+profit+"&credit="+credit+"&typeofanalysis="+typeofanalysis);

   if(typeofanalysis==2 && TimeGMT()>TimeCurrent())
     {
      //----------Break POwer
      int shoro=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q-1));
      ObjectCreate("ML StartTradeWeekH4",OBJ_VLINE,0,iTime(NULL,PERIOD_H4,shoro-1),iOpen(NULL,PERIOD_H4,shoro-1));
      ObjectSet("ML StartTradeWeekH4",OBJPROP_STYLE,STYLE_DOT);
      ObjectSet("ML StartTradeWeekH4",OBJPROP_COLOR,Green);
      ObjectSet("ML StartTradeWeekH4",OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);

      int powerID;
      string timepower;
      string signalpower;
      int breaktimepower;
      string penetrationbreak;
      double powerLow;
      double powerLow2=iOpen(NULL,PERIOD_H4,shoro-1);
      double powerHigh;
      double powerHigh2=iOpen(NULL,PERIOD_H4,shoro-1);

      for(jojo=shoro-1;jojo>=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q)+14*24*60*60); jojo--)
        {
         if(iHigh(NULL,PERIOD_H4,jojo)>TL)
           {
            pattern=2;
            for(powerID=shoro-1;powerID>=jojo;powerID--)
              {
               powerLow=iLow(NULL,PERIOD_H4,powerID);
               if(powerLow<powerLow2)
                 {
                  powerLow2=powerLow;
                 }

              }
            break;
           }
         if(iLow(NULL,PERIOD_H4,jojo)<LL)
           {
            pattern=1;
            for(powerID=shoro-1;powerID>=jojo;powerID--)
              {
               powerHigh=iHigh(NULL,PERIOD_H4,powerID);
               if(powerHigh>powerHigh2)
                 {
                  powerHigh2=powerHigh;
                 }

              }
            break;
           }

        }
      if(pattern==2)
        {
         for(jojo3=shoro-1;jojo3>=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q-1)+6*24*60*60); jojo3--)
           {
            if(iHigh(NULL,PERIOD_H4,jojo3)<minTL3 && iHigh(NULL,PERIOD_H4,jojo3)>TL)
              {
               penetrationbreak="Not-Confirmed";
              }
            if(iHigh(NULL,PERIOD_H4,jojo3)>minTL3 && iHigh(NULL,PERIOD_H4,jojo3)>TL)
              {
               penetrationbreak="Confirmed";
              }

            if(penetrationbreak=="Confirmed") break;
           }
        }

      if(pattern==1)
        {
         for(jojo3=shoro-1;jojo3>=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q-1)+6*24*60*60); jojo3--)
           {
            if(iLow(NULL,PERIOD_H4,jojo3)>minLL3 && iLow(NULL,PERIOD_H4,jojo3)<LL)
              {
               penetrationbreak="Not-Confirmed";
              }

            if(iLow(NULL,PERIOD_H4,jojo3)<minLL3 && iLow(NULL,PERIOD_H4,jojo3)<LL)
              {
               penetrationbreak="Confirmed";
              }

            if(penetrationbreak=="Confirmed") break;

           }
        }

      if(pattern==1 || pattern==2)
        {
         breaktimepower=shoro-jojo;
         if(breaktimepower<=10)timepower="High";
         if(breaktimepower>10 && breaktimepower<=20)timepower="Medium";
         if(breaktimepower>20)timepower="Low";
         ObjectCreate("ML ORDERALLOWtimepower",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWtimepower",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWtimepower",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWtimepower",OBJPROP_YDISTANCE,20);
         ObjectSetText("ML ORDERALLOWtimepower","Break Power (Time Break) ="+timepower,10,"arial",Red);
        }

      double power;
      string power2;

      if(pattern==2)
        {
         power=NormalizeDouble(((TL-powerLow2)/(TL-LL)),2);
         if(power>=0.6)power2="High";
         if(power<0.6 && power>=0.3)power2="Medium";
         if(power<0.3)power2="Low";
         ObjectCreate("ML ORDERALLOWpricemovepower",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpricemovepower",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpricemovepower",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpricemovepower",OBJPROP_YDISTANCE,5);
         ObjectSetText("ML ORDERALLOWpricemovepower","Break Power (Price Move) ="+power2,10,"arial",Red);
        }

      if(pattern==1)
        {
         power=NormalizeDouble(((powerHigh2-LL)/(TL-LL)),2);
         if(power>=0.6)power2="High";
         if(power<0.6 && power>=0.3)power2="Medium";
         if(power<0.3)power2="Low";
         ObjectCreate("ML ORDERALLOWpricemovepower",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpricemovepower",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpricemovepower",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpricemovepower",OBJPROP_YDISTANCE,5);
         ObjectSetText("ML ORDERALLOWpricemovepower","Break Power (Price Move) ="+power2,10,"arial",Red);
        }

      if(power2=="High"&& timepower=="High")signalpower=" Strong";
      if(power2=="High" && timepower=="High" && penetrationbreak=="Confirmed")signalpower=" Very Strong (Gold)";

      if(power2=="High" && timepower=="Medium")signalpower=" Strong";
      if(power2=="High" && timepower=="Medium" && penetrationbreak=="Confirmed")signalpower=" Very Strong";

      if(power2=="High" && timepower=="Low")signalpower=" Medium";
      if(power2=="High" && timepower=="Low" && penetrationbreak=="Confirmed")signalpower=" Medium +";

      if(power2=="Medium" && timepower=="High")signalpower=" Strong";
      if(power2=="Medium" && timepower=="High" && penetrationbreak=="Confirmed")signalpower=" Very Strong";

      if(power2=="Medium" && timepower=="Medium")signalpower=" Medium";
      if(power2=="Medium" && timepower=="Medium" && penetrationbreak=="Confirmed")signalpower=" Medium +";

      if(power2=="Medium" && timepower=="Low")signalpower=" Medium";
      if(power2=="Medium" && timepower=="Low" && penetrationbreak=="Confirmed")signalpower=" Medium +";

      if(power2=="Low" && timepower=="High")signalpower=" Medium";
      if(power2=="Low" && timepower=="High" && penetrationbreak=="Confirmed")signalpower=" Medium +";

      if(power2=="Low" && timepower=="Medium")signalpower=" Weak";
      if(power2=="Low" && timepower=="Medium"&& penetrationbreak=="Confirmed")signalpower=" Weak +";

      if(power2=="Low" && timepower=="Low")signalpower="  Very Weak";
      if(power2=="Low" && timepower=="Low" && penetrationbreak=="Confirmed")signalpower=" Very Weak +";

      if(pattern==0)signalpower="No Confirmation(no Signal)";

      if(pattern==1 || pattern==2)
        {
         ObjectCreate("ML ORDERALLOWsignalpower",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWsignalpower",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWsignalpower",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWsignalpower",OBJPROP_YDISTANCE,50);
         ObjectSetText("ML ORDERALLOWsignalpower","Signal Strength ="+signalpower,10,"arial",Blue);
        }

      if(pattern==0)
        {
         ObjectCreate("ML ORDERALLOWsignalpower",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWsignalpower",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWsignalpower",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWsignalpower",OBJPROP_YDISTANCE,50);
         ObjectSetText("ML ORDERALLOWsignalpower","Signal Strength ="+signalpower,10,"arial",Brown);
        }

      if(penetrationbreak=="Confirmed")
        {
         ObjectCreate("ML ORDERALLOWpenetrationbreak",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpenetrationbreak",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpenetrationbreak",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpenetrationbreak",OBJPROP_YDISTANCE,35);
         ObjectSetText("ML ORDERALLOWpenetrationbreak","Break Penetration ="+penetrationbreak,10,"arial",Green);
        }
      if(penetrationbreak=="Not-Confirmed")
        {
         ObjectCreate("ML ORDERALLOWpenetrationbreak",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpenetrationbreak",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpenetrationbreak",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpenetrationbreak",OBJPROP_YDISTANCE,35);
         ObjectSetText("ML ORDERALLOWpenetrationbreak","Break Penetration ="+penetrationbreak,10,"arial",Brown);
        }

      int orderallow=1;
      if(pattern==2)
        {
         for(jojo=shoro-1;jojo>=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q-1)+6*24*60*59.9); jojo--)
           {

            if(iHigh(NULL,PERIOD_H4,jojo)>minTL2 || iLow(NULL,PERIOD_H4,jojo)<minLL2)
              {
               orderallow=0;
              }

           }
        }
      if(pattern==1)
        {
         for(jojo=shoro-1;jojo>=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q-1)+6*24*60*59.9); jojo--)
           {
            if(iLow(NULL,PERIOD_H4,jojo)<minLL2 || iHigh(NULL,PERIOD_H4,jojo)>minTL2)
              {
               orderallow=0;
              }

           }
        }

      if(orderallow==0)
        {
         string tradeallow="BE CAREFULL NO TRADE ANY MORE";
         ObjectCreate("ML ORDERALLOW",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOW",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOW",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOW",OBJPROP_YDISTANCE,70);
         ObjectSetText("ML ORDERALLOW",tradeallow,18,"arial",Red);
        }
     }

   if(typeofanalysis==3 && TimeGMT()>TimeCurrent())
     {
      int jojomonthly;
      int NOfOrdersmonthly=0;
      int TicketBmonthly = 0;
      int TicketSmonthly = 0;
      int TicketBPmonthly = 0;
      int TicketSPmonthly = 0;
      for(int imonthly=0;imonthly<OrdersTotal();imonthly++)
        {
         if(OrderSelect(imonthly,SELECT_BY_POS)==false)
            return(-1);
         if(OrderSymbol()!=Symbol())
            continue;
         if(OrderMagicNumber()!=30)
            continue;

         if(OrderType()==OP_BUY)TicketBmonthly=OrderTicket();
         if(OrderType()==OP_SELL)TicketSmonthly=OrderTicket();
         if(OrderType()==OP_BUYLIMIT)TicketBPmonthly=OrderTicket();
         if(OrderType()==OP_SELLLIMIT)TicketSPmonthly=OrderTicket();

         NOfOrdersmonthly++;
        }

      int shoromonthly=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q-1));
      ObjectCreate("ML StartTradeWeekH4Monthly",OBJ_VLINE,0,iTime(NULL,PERIOD_D1,shoromonthly-1),iOpen(NULL,PERIOD_D1,shoromonthly-1));
      ObjectSet("ML StartTradeWeekH4Monthly",OBJPROP_STYLE,STYLE_DOT);
      ObjectSet("ML StartTradeWeekH4Monthly",OBJPROP_COLOR,Green);
      ObjectSet("ML StartTradeWeekH4Monthly",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);

      int breaktimepowermonthly;
      int countcloseupmonthly=0;
      int countclosedownmonthly=0;
      int powerIDmonthly;
      double powerLowmonthly;
      string penetrationbreakmonthly;
      double powerLow2monthly=iOpen(NULL,PERIOD_D1,shoromonthly-1);
      double powerHighmonthly;
      double powerHigh2monthly=iOpen(NULL,PERIOD_D1,shoromonthly-1);
      string timepowermonthly;
      string signalpowermonthly;
      int patternmonthly;
      int jojo3monthly;

      for(jojomonthly=shoromonthly-1;jojomonthly>=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q)+60*24*60*60); jojomonthly--)
        {

         if(iHigh(NULL,PERIOD_H4,jojomonthly)>TLmonthly)
           {
            patternmonthly=2;
            for(powerIDmonthly=shoromonthly-1;powerIDmonthly>=jojomonthly;powerIDmonthly--)
              {
               powerLowmonthly=iLow(NULL,PERIOD_D1,powerIDmonthly);
               if(powerLowmonthly<powerLow2monthly)
                 {
                  powerLow2monthly=powerLowmonthly;
                 }

              }
            break;
           }
         if(iLow(NULL,PERIOD_D1,jojomonthly)<LLmonthly)
           {
            patternmonthly=1;
            for(powerIDmonthly=shoromonthly-1;powerIDmonthly>=jojomonthly;powerIDmonthly--)
              {
               powerHighmonthly=iHigh(NULL,PERIOD_D1,powerIDmonthly);
               if(powerHighmonthly>powerHigh2monthly)
                 {
                  powerHigh2monthly=powerHighmonthly;
                 }

              }
            break;
           }

        }

      if(patternmonthly==2)
        {
         for(jojo3monthly=shoromonthly-1;jojo3monthly>=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q)+60*24*60*60); jojo3monthly--)
           {

            if(iHigh(NULL,PERIOD_D1,jojo3monthly)<minTL3monthly && iHigh(NULL,PERIOD_D1,jojo3monthly)>TLmonthly)
              {
               penetrationbreakmonthly="Not-Confirmed";
              }

            if(iHigh(NULL,PERIOD_D1,jojo3monthly)>minTL3monthly && iHigh(NULL,PERIOD_D1,jojo3monthly)>TLmonthly)
              {
               penetrationbreakmonthly="Confirmed";
              }

            if(penetrationbreakmonthly=="Confirmed") break;
           }
        }
      if(patternmonthly==1)
        {
         for(jojo3monthly=shoromonthly-1;jojo3monthly>=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q)+60*24*60*60); jojo3monthly--)
           {
            if(iLow(NULL,PERIOD_D1,jojo3monthly)>minLL3monthly && iLow(NULL,PERIOD_D1,jojo3monthly)<LLmonthly)
              {
               penetrationbreakmonthly="Not-Confirmed";
              }

            if(iLow(NULL,PERIOD_D1,jojo3monthly)<minLL3monthly && iLow(NULL,PERIOD_D1,jojo3monthly)<LLmonthly)
              {
               penetrationbreakmonthly="Confirmed";
              }

            if(penetrationbreakmonthly=="Confirmed") break;
           }
        }

      if(patternmonthly==1 || patternmonthly==2)
        {
         breaktimepowermonthly=shoromonthly-jojomonthly;
         if(breaktimepowermonthly<=7)timepowermonthly="High";
         if(breaktimepowermonthly>7 && breaktimepowermonthly<=14)timepowermonthly="Medium";
         if(breaktimepowermonthly>14)timepowermonthly="Low";
         ObjectCreate("ML ORDERALLOWtimepowermonthly",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWtimepowermonthly",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWtimepowermonthly",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWtimepowermonthly",OBJPROP_YDISTANCE,20);
         ObjectSetText("ML ORDERALLOWtimepowermonthly","Break Power (Time Break) ="+timepowermonthly,10,"arial",Red);
        }
      double powermonthly;
      string power2monthly;
      if(patternmonthly==2)
        {
         powermonthly=NormalizeDouble(((TLmonthly-powerLow2monthly)/(TLmonthly-LLmonthly)),2);
         if(powermonthly>=0.6)power2monthly="High";
         if(powermonthly<0.6 && powermonthly>=0.3)power2monthly="Medium";
         if(powermonthly<0.3)power2monthly="Low";
         ObjectCreate("ML ORDERALLOWpricemovepowermonthly",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpricemovepowermonthly",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpricemovepowermonthly",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpricemovepowermonthly",OBJPROP_YDISTANCE,5);
         ObjectSetText("ML ORDERALLOWpricemovepowermonthly","Break Power (Price Move) ="+power2monthly,10,"arial",Red);
        }
      if(patternmonthly==1)
        {
         powermonthly=NormalizeDouble(((powerHigh2monthly-LLmonthly)/(TLmonthly-LLmonthly)),2);
         if(powermonthly>=0.6)power2monthly="High";
         if(powermonthly<0.6 && powermonthly>=0.3)power2monthly="Medium";
         if(powermonthly<0.3)power2monthly="Low";
         ObjectCreate("ML ORDERALLOWpricemovepowermonthly",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpricemovepowermonthly",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpricemovepowermonthly",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpricemovepowermonthly",OBJPROP_YDISTANCE,5);
         ObjectSetText("ML ORDERALLOWpricemovepowermonthly","Break Power (Price Move) ="+power2monthly,10,"arial",Red);
        }

      if(power2monthly=="High" && timepowermonthly=="High")signalpowermonthly=" Strong";
      if(power2monthly=="High" && timepowermonthly=="High" && penetrationbreakmonthly=="Confirmed")signalpowermonthly=" Very Strong (Gold)";

      if(power2monthly=="High" && timepowermonthly=="Medium")signalpowermonthly=" Strong";
      if(power2monthly=="High" && timepowermonthly=="Medium" && penetrationbreakmonthly=="Confirmed")signalpowermonthly=" Very Strong";

      if(power2monthly=="High" && timepowermonthly=="Low")signalpowermonthly=" Medium";
      if(power2monthly=="High" && timepowermonthly=="Low" && penetrationbreakmonthly=="Confirmed")signalpowermonthly=" Medium +";

      if(power2monthly=="Medium" && timepowermonthly=="High")signalpowermonthly=" Strong";
      if(power2monthly=="Medium" && timepowermonthly=="High" && penetrationbreakmonthly=="Confirmed")signalpowermonthly=" Very Strong";

      if(power2monthly=="Medium" && timepowermonthly=="Medium")signalpowermonthly=" Medium";
      if(power2monthly=="Medium" && timepowermonthly=="Medium" && penetrationbreakmonthly=="Confirmed")signalpowermonthly=" Medium +";

      if(power2monthly=="Medium" && timepowermonthly=="Low")signalpowermonthly=" Medium";
      if(power2monthly=="Medium" && timepowermonthly=="Low" && penetrationbreakmonthly=="Confirmed")signalpowermonthly=" Medium +";

      if(power2monthly=="Low" && timepowermonthly=="High")signalpowermonthly=" Medium";
      if(power2monthly=="Low" && timepowermonthly=="High" && penetrationbreakmonthly=="Confirmed")signalpowermonthly=" Medium +";

      if(power2monthly=="Low" && timepowermonthly=="Medium")signalpowermonthly=" Weak";
      if(power2monthly=="Low" && timepowermonthly=="Medium"&& penetrationbreakmonthly=="Confirmed")signalpowermonthly=" Weak +";

      if(power2monthly=="Low" && timepowermonthly=="Low")signalpowermonthly="  Very Weak";
      if(power2monthly=="Low" && timepowermonthly=="Low" && penetrationbreakmonthly=="Confirmed")signalpowermonthly=" Very Weak +";

      if(patternmonthly==0)signalpowermonthly="No Confirmation(no Signal)";

      if(patternmonthly==1 || patternmonthly==2)
        {
         ObjectCreate("ML ORDERALLOWsignalpowermonthly",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWsignalpowermonthly",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWsignalpowermonthly",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWsignalpowermonthly",OBJPROP_YDISTANCE,50);
         ObjectSetText("ML ORDERALLOWsignalpowermonthly","Signal Strength ="+signalpowermonthly,10,"arial",Blue);
        }
      if(patternmonthly==0)
        {
         ObjectCreate("ML ORDERALLOWsignalpowermonthly",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWsignalpowermonthly",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWsignalpowermonthly",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWsignalpowermonthly",OBJPROP_YDISTANCE,50);
         ObjectSetText("ML ORDERALLOWsignalpowermonthly","Signal Strength ="+signalpowermonthly,10,"arial",Brown);
        }

      if(penetrationbreakmonthly=="Confirmed")
        {
         ObjectCreate("ML ORDERALLOWpenetrationbreakmonthly",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpenetrationbreakmonthly",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpenetrationbreakmonthly",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpenetrationbreakmonthly",OBJPROP_YDISTANCE,35);
         ObjectSetText("ML ORDERALLOWpenetrationbreakmonthly","Break Penetration ="+penetrationbreakmonthly,10,"arial",Green);
        }
      if(penetrationbreakmonthly=="Not-Confirmed")
        {
         ObjectCreate("ML ORDERALLOWpenetrationbreakmonthly",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpenetrationbreakmonthly",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpenetrationbreakmonthly",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpenetrationbreakmonthly",OBJPROP_YDISTANCE,35);
         ObjectSetText("ML ORDERALLOWpenetrationbreakmonthly","Break Penetration ="+penetrationbreakmonthly,10,"arial",Brown);
        }

      if(patternmonthly==2)
        {
         for(jojomonthly=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q)+60*24*60*60);jojomonthly<=shoromonthly-1; jojomonthly++)
           {
            if(iClose(NULL,PERIOD_D1,jojomonthly)>TLmonthly && jojomonthly!=0)
              {
               countcloseupmonthly++;
              }
           }
        }

      if(patternmonthly==1)
        {
         for(jojomonthly=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q)+60*24*60*60);jojomonthly<=shoromonthly-1; jojomonthly++)
           {
            if(iClose(NULL,PERIOD_D1,jojomonthly)<LLmonthly && jojomonthly!=0)
              {
               countclosedownmonthly++;
              }
           }

        }

      int orderallowmonthly=1;
      if(patternmonthly==2)
        {
         for(jojomonthly=shoromonthly-1;jojomonthly>=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q)+60*24*60*60); jojomonthly--)
           {

            if(iHigh(NULL,PERIOD_D1,jojomonthly)>minTL2monthly)
              {
               orderallowmonthly=0;
              }

           }
        }
      if(patternmonthly==1)
        {
         for(jojomonthly=shoromonthly-1;jojomonthly>=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q)+60*24*60*60); jojomonthly--)
           {
            if(iLow(NULL,PERIOD_D1,jojomonthly)<minLL2monthly)
              {
               orderallowmonthly=0;
              }

           }
        }

      if(orderallowmonthly==0)
        {
         string tradeallowmonthly="BE CAREFULL NO TRADE ANY MORE";
         ObjectCreate("ML ORDERALLOWmonthly",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWmonthly",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWmonthly",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWmonthly",OBJPROP_YDISTANCE,70);
         ObjectSetText("ML ORDERALLOWmonthly",tradeallowmonthly,18,"arial",Red);
        }

     }

   if(typeofanalysis==1 && TimeGMT()>TimeCurrent())
     {
      int jojodaily;
      int NOfOrdersdaily=0;
      int TicketBdaily = 0;
      int TicketSdaily = 0;
      int TicketBPdaily = 0;
      int TicketSPdaily = 0;
      for(int idaily=0;idaily<OrdersTotal();idaily++)
        {
         if(OrderSelect(idaily,SELECT_BY_POS)==false)
            return(-1);
         if(OrderSymbol()!=Symbol())
            continue;
         if(OrderMagicNumber()!=24)
            continue;

         if(OrderType()==OP_BUY)TicketBdaily=OrderTicket();
         if(OrderType()==OP_SELL)TicketSdaily=OrderTicket();
         if(OrderType()==OP_BUYLIMIT)TicketBPdaily=OrderTicket();
         if(OrderType()==OP_SELLLIMIT)TicketSPdaily=OrderTicket();

         NOfOrdersdaily++;
        }

      int shorodaily=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q-1));
      ObjectCreate("ML StartTradeWeekH4daily",OBJ_VLINE,0,iTime(NULL,PERIOD_H1,shorodaily-1),iOpen(NULL,PERIOD_H1,shorodaily-1));
      ObjectSet("ML StartTradeWeekH4daily",OBJPROP_STYLE,STYLE_DOT);
      ObjectSet("ML StartTradeWeekH4daily",OBJPROP_COLOR,Green);
      ObjectSet("ML StartTradeWeekH4daily",OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);

      int breaktimepowerdaily;
      int countcloseupdaily=0;
      int countclosedowndaily=0;
      int powerIDdaily;
      double powerLowdaily;
      string penetrationbreakdaily;
      double powerLow2daily=iOpen(NULL,PERIOD_H1,shorodaily-1);
      double powerHighdaily;
      double powerHigh2daily=iOpen(NULL,PERIOD_H1,shorodaily-1);
      string timepowerdaily;
      string signalpowerdaily;
      int patterndaily;
      int jojo3daily;

      for(jojodaily=shorodaily-1;jojodaily>=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q-1)+1*24*60*60); jojodaily--)
        {

         if(iHigh(NULL,PERIOD_H1,jojodaily)>TLdaily)
           {
            patterndaily=2;
            for(powerIDdaily=shorodaily-1;powerIDdaily>=jojodaily;powerIDdaily--)
              {
               powerLowdaily=iLow(NULL,PERIOD_H1,powerIDdaily);
               if(powerLowdaily<powerLow2daily)
                 {
                  powerLow2daily=powerLowdaily;
                 }

              }
            break;
           }
         if(iLow(NULL,PERIOD_H1,jojodaily)<LLdaily)
           {
            patterndaily=1;
            for(powerIDdaily=shorodaily-1;powerIDdaily>=jojodaily;powerIDdaily--)
              {
               powerHighdaily=iHigh(NULL,PERIOD_H1,powerIDdaily);
               if(powerHighdaily>powerHigh2daily)
                 {
                  powerHigh2daily=powerHighdaily;
                 }

              }
            break;
           }

        }

      if(patterndaily==2)
        {
         for(jojo3daily=shorodaily-1;jojo3daily>=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q-1)+1*24*60*60); jojo3daily--)
           {

            if(iHigh(NULL,PERIOD_H1,jojo3daily)<minTL3daily && iHigh(NULL,PERIOD_H1,jojo3daily)>TLdaily)
              {
               penetrationbreakdaily="Not-Confirmed";
              }

            if(iHigh(NULL,PERIOD_H1,jojo3daily)>minTL3daily && iHigh(NULL,PERIOD_H1,jojo3daily)>TLdaily)
              {
               penetrationbreakdaily="Confirmed";
              }

            if(penetrationbreakdaily=="Confirmed") break;

           }
        }

      if(patterndaily==1)
        {
         for(jojo3daily=shorodaily-1;jojo3daily>=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q-1)+1*24*60*60); jojo3daily--)
           {

            if(iLow(NULL,PERIOD_H1,jojo3daily)>minLL3daily && iLow(NULL,PERIOD_H1,jojo3daily)<LLdaily)
              {
               penetrationbreakdaily="Not-Confirmed";
              }

            if(iLow(NULL,PERIOD_H1,jojo3daily)<minLL3daily && iLow(NULL,PERIOD_H1,jojo3daily)<LLdaily)
              {
               penetrationbreakdaily="Confirmed";
              }

            if(penetrationbreakdaily=="Confirmed") break;
           }
        }

      if(patterndaily==1 || patterndaily==2)
        {
         breaktimepowerdaily=shorodaily-jojodaily;
         if(breaktimepowerdaily<=8)timepowerdaily="High";
         if(breaktimepowerdaily>8 && breaktimepowerdaily<=16)timepowerdaily="Medium";
         if(breaktimepowerdaily>16)timepowerdaily="Low";
         ObjectCreate("ML ORDERALLOWtimepowerdaily",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWtimepowerdaily",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWtimepowerdaily",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWtimepowerdaily",OBJPROP_YDISTANCE,20);
         ObjectSetText("ML ORDERALLOWtimepowerdaily","Break Power (Time Break) ="+timepowerdaily,10,"arial",Red);
        }
      double powerdaily;
      string power2daily;
      if(patterndaily==2)
        {
         powerdaily=NormalizeDouble(((TLdaily-powerLow2daily)/(TLdaily-LLdaily)),2);
         if(powerdaily>=0.6)power2daily="High";
         if(powerdaily<0.6 && powerdaily>=0.3)power2daily="Medium";
         if(powerdaily<0.3)power2daily="Low";
         ObjectCreate("ML ORDERALLOWpricemovepowerdaily",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpricemovepowerdaily",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpricemovepowerdaily",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpricemovepowerdaily",OBJPROP_YDISTANCE,5);
         ObjectSetText("ML ORDERALLOWpricemovepowerdaily","Break Power (Price Move) ="+power2daily,10,"arial",Red);
        }
      if(patterndaily==1)
        {
         powerdaily=NormalizeDouble(((powerHigh2daily-LLdaily)/(TLdaily-LLdaily)),2);
         if(powerdaily>=0.6)power2daily="High";
         if(powerdaily<0.6 && powerdaily>=0.3)power2daily="Medium";
         if(powerdaily<0.3)power2daily="Low";
         ObjectCreate("ML ORDERALLOWpricemovepowerdaily",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpricemovepowerdaily",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpricemovepowerdaily",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpricemovepowerdaily",OBJPROP_YDISTANCE,5);
         ObjectSetText("ML ORDERALLOWpricemovepowerdaily","Break Power (Price Move) ="+power2daily,10,"arial",Red);
        }

      if(power2daily=="High" && timepowerdaily=="High")signalpowerdaily=" Strong";
      if(power2daily=="High" && timepowerdaily=="High" && penetrationbreakdaily=="Confirmed")signalpowerdaily=" Very Strong (Gold)";

      if(power2daily=="High" && timepowerdaily=="Medium")signalpowerdaily=" Strong";
      if(power2daily=="High" && timepowerdaily=="Medium" && penetrationbreakdaily=="Confirmed")signalpowerdaily=" Very Strong";

      if(power2daily=="High" && timepowerdaily=="Low")signalpowerdaily=" Medium";
      if(power2daily=="High" && timepowerdaily=="Low" && penetrationbreakdaily=="Confirmed")signalpowerdaily=" Medium +";

      if(power2daily=="Medium" && timepowerdaily=="High")signalpowerdaily=" Strong";
      if(power2daily=="Medium" && timepowerdaily=="High" && penetrationbreakdaily=="Confirmed")signalpowerdaily=" Very Strong";

      if(power2daily=="Medium" && timepowerdaily=="Medium")signalpowerdaily=" Medium";
      if(power2daily=="Medium" && timepowerdaily=="Medium" && penetrationbreakdaily=="Confirmed")signalpowerdaily=" Medium +";

      if(power2daily=="Medium" && timepowerdaily=="Low")signalpowerdaily=" Medium";
      if(power2daily=="Medium" && timepowerdaily=="Low" && penetrationbreakdaily=="Confirmed")signalpowerdaily=" Medium +";

      if(power2daily=="Low" && timepowerdaily=="High")signalpowerdaily=" Medium";
      if(power2daily=="Low" && timepowerdaily=="High" && penetrationbreakdaily=="Confirmed")signalpowerdaily=" Medium +";

      if(power2daily=="Low" && timepowerdaily=="Medium")signalpowerdaily=" Weak";
      if(power2daily=="Low" && timepowerdaily=="Medium"&& penetrationbreakdaily=="Confirmed")signalpowerdaily=" Weak +";

      if(power2daily=="Low" && timepowerdaily=="Low")signalpowerdaily="  Very Weak";
      if(power2daily=="Low" && timepowerdaily=="Low" && penetrationbreakdaily=="Confirmed")signalpowerdaily=" Very Weak +";

      if(patterndaily==0)signalpowerdaily="No Confirmation(no Signal)";

      if(patterndaily==1 || patterndaily==2)
        {
         ObjectCreate("ML ORDERALLOWsignalpowerdaily",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWsignalpowerdaily",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWsignalpowerdaily",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWsignalpowerdaily",OBJPROP_YDISTANCE,50);
         ObjectSetText("ML ORDERALLOWsignalpowerdaily","Signal Strength ="+signalpowerdaily,10,"arial",Blue);
        }
      if(patterndaily==0)
        {
         ObjectCreate("ML ORDERALLOWsignalpowerdaily",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWsignalpowerdaily",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWsignalpowerdaily",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWsignalpowerdaily",OBJPROP_YDISTANCE,50);
         ObjectSetText("ML ORDERALLOWsignalpowerdaily","Signal Strength ="+signalpowerdaily,10,"arial",Brown);
        }

      if(penetrationbreakdaily=="Confirmed")
        {
         ObjectCreate("ML ORDERALLOWpenetrationbreakdaily",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpenetrationbreakdaily",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpenetrationbreakdaily",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpenetrationbreakdaily",OBJPROP_YDISTANCE,35);
         ObjectSetText("ML ORDERALLOWpenetrationbreakdaily","Break Penetration ="+penetrationbreakdaily,10,"arial",Green);
        }
      if(penetrationbreakdaily=="Not-Confirmed")
        {
         ObjectCreate("ML ORDERALLOWpenetrationbreakdaily",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpenetrationbreakdaily",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpenetrationbreakdaily",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpenetrationbreakdaily",OBJPROP_YDISTANCE,35);
         ObjectSetText("ML ORDERALLOWpenetrationbreakdaily","Break Penetration ="+penetrationbreakdaily,10,"arial",Brown);
        }

      if(patterndaily==2)
        {
         for(jojodaily=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q)+1*24*60*60);jojodaily<=shorodaily-1; jojodaily++)
           {
            if(iClose(NULL,PERIOD_H1,jojodaily)>TLdaily && jojodaily!=0)
              {
               countcloseupdaily++;
              }
           }
        }

      if(patterndaily==1)
        {
         for(jojodaily=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q)+1*24*60*60);jojodaily<=shorodaily-1; jojodaily++)
           {
            if(iClose(NULL,PERIOD_H1,jojodaily)<LLdaily && jojodaily!=0)
              {
               countclosedowndaily++;
              }
           }

        }

      int orderallowdaily=1;
      if(patterndaily==2)
        {
         for(jojodaily=shorodaily-1;jojodaily>=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q-1)+1*24*60*60); jojodaily--)
           {

            if(iHigh(NULL,PERIOD_H1,jojodaily)>minTL2daily)
              {
               orderallowdaily=0;
              }

           }
        }
      if(patterndaily==1)
        {
         for(jojodaily=shorodaily-1;jojodaily>=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q-1)+1*24*60*60); jojodaily--)
           {
            if(iLow(NULL,PERIOD_H1,jojodaily)<minLL2daily)
              {
               orderallowdaily=0;
              }

           }
        }

      if(orderallowdaily==0)
        {
         string tradeallowdaily="BE CAREFULL NO TRADE ANY MORE";
         ObjectCreate("ML ORDERALLOWdaily",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWdaily",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWdaily",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWdaily",OBJPROP_YDISTANCE,70);
         ObjectSetText("ML ORDERALLOWdaily",tradeallowdaily,18,"arial",Red);
        }

     }

   return(0);
  }
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {
//--- destroy timer
   EventKillTimer();
   Comment("");
   int  obj_total=ObjectsTotal();
   for(k=obj_total; k>=0; k--)
     {
      string name=ObjectName(k);
      if(StringSubstr(name,0,3)=="ML "){ObjectDelete(name);}
     }
   int  obj_total2=ObjectsTotal();
   Sleep(100);
   for(k=obj_total2; k>=0; k--)
     {
      string name2=ObjectName(k);
      if(StringSubstr(name2,0,3)=="ML "){ObjectDelete(name2);}
     }
   return(0);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   string typeofanalysisstring;
   if(typeofanalysis==1) typeofanalysisstring="Daily";
   if(typeofanalysis==2) typeofanalysisstring="Weekly";
   if(typeofanalysis==3) typeofanalysisstring="Monthly";
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(typeofanalysis==2)
     {
      int Ticketselldor;
      int countTicketselldor;
      int Ticketsellmiani;
      int countTicketsellmiani;
      int Ticketbuydor;
      int countTicketbuydor;
      int Ticketbuymiani;
      int countTicketbuymiani;
      bool Ticketselldormodify;
      bool Ticketsellmianimodify;
      bool Ticketbuydormodify;
      bool Ticketbuymianimodify;

      int NOfOrders=0;
      int TicketB = 0;
      int TicketS = 0;
      int TicketBP = 0;
      int TicketSP = 0;
      for(int i=0;i<OrdersTotal();i++)
        {
         if(OrderSelect(i,SELECT_BY_POS)==false)
            return(-1);
         if(OrderSymbol()!=Symbol())
            continue;
         if(OrderMagicNumber()!=12)
            continue;

         if(OrderType()==OP_BUY)TicketB=OrderTicket();
         if(OrderType()==OP_SELL)TicketS=OrderTicket();
         if(OrderType()==OP_BUYLIMIT)TicketBP=OrderTicket();
         if(OrderType()==OP_SELLLIMIT)TicketSP=OrderTicket();

         NOfOrders++;
        }

      int shoro=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q-1));
      ObjectCreate("ML StartTradeWeekH4",OBJ_VLINE,0,iTime(NULL,PERIOD_H4,shoro-1),iOpen(NULL,PERIOD_W1,shoro-1));
      ObjectSet("ML StartTradeWeekH4",OBJPROP_STYLE,STYLE_DOT);
      ObjectSet("ML StartTradeWeekH4",OBJPROP_COLOR,Green);
      ObjectSet("ML StartTradeWeekH4",OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);

      int breaktimepower;
      int countcloseup=0;
      int countclosedown=0;
      int powerID;
      double powerLow;
      string penetrationbreak;
      double powerLow2=iOpen(NULL,PERIOD_H4,shoro-1);
      double powerHigh;
      double powerHigh2=iOpen(NULL,PERIOD_H4,shoro-1);
      string timepower;
      string signalpower;

      for(jojo=shoro-1;jojo>=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q)+14*24*60*60); jojo--)
        {

         if(iHigh(NULL,PERIOD_H4,jojo)>TL)
           {
            pattern=2;
            for(powerID=shoro-1;powerID>=jojo;powerID--)
              {
               powerLow=iLow(NULL,PERIOD_H4,powerID);
               if(powerLow<powerLow2)
                 {
                  powerLow2=powerLow;
                 }

              }
            break;
           }
         if(iLow(NULL,PERIOD_H4,jojo)<LL)
           {
            pattern=1;
            for(powerID=shoro-1;powerID>=jojo;powerID--)
              {
               powerHigh=iHigh(NULL,PERIOD_H4,powerID);
               if(powerHigh>powerHigh2)
                 {
                  powerHigh2=powerHigh;
                 }

              }
            break;
           }

        }

      if(pattern==2)
        {
         for(jojo3=shoro-1;jojo3>=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q-1)+6*24*60*60); jojo3--)
           {
            if(iHigh(NULL,PERIOD_H4,jojo3)<minTL3 && iHigh(NULL,PERIOD_H4,jojo3)>TL)
              {
               penetrationbreak="Not-Confirmed";
              }
            if(iHigh(NULL,PERIOD_H4,jojo3)>minTL3 && iHigh(NULL,PERIOD_H4,jojo3)>TL)
              {
               penetrationbreak="Confirmed";
              }

            if(penetrationbreak=="Confirmed") break;
           }
        }

      if(pattern==1)
        {
         for(jojo3=shoro-1;jojo3>=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q-1)+6*24*60*60); jojo3--)
           {
            if(iLow(NULL,PERIOD_H4,jojo3)>minLL3 && iLow(NULL,PERIOD_H4,jojo3)<LL)
              {
               penetrationbreak="Not-Confirmed";
              }

            if(iLow(NULL,PERIOD_H4,jojo3)<minLL3 && iLow(NULL,PERIOD_H4,jojo3)<LL)
              {
               penetrationbreak="Confirmed";
              }

            if(penetrationbreak=="Confirmed") break;

           }
        }

      if(pattern==1 || pattern==2)
        {
         breaktimepower=shoro-jojo;
         if(breaktimepower<=10)timepower="High";
         if(breaktimepower>10 && breaktimepower<=20)timepower="Medium";
         if(breaktimepower>20)timepower="Low";
         ObjectCreate("ML ORDERALLOWtimepower",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWtimepower",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWtimepower",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWtimepower",OBJPROP_YDISTANCE,20);
         ObjectSetText("ML ORDERALLOWtimepower","Break Power (Time Break) ="+timepower,10,"arial",Red);
        }
      double power;
      string power2;
      if(pattern==2)
        {
         power=NormalizeDouble(((TL-powerLow2)/(TL-LL)),2);
         if(power>=0.6)power2="High";
         if(power<0.6 && power>=0.3)power2="Medium";
         if(power<0.3)power2="Low";
         ObjectCreate("ML ORDERALLOWpricemovepower",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpricemovepower",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpricemovepower",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpricemovepower",OBJPROP_YDISTANCE,5);
         ObjectSetText("ML ORDERALLOWpricemovepower","Break Power (Price Move) ="+power2,10,"arial",Red);
        }
      if(pattern==1)
        {
         power=NormalizeDouble(((powerHigh2-LL)/(TL-LL)),2);
         if(power>=0.6)power2="High";
         if(power<0.6 && power>=0.3)power2="Medium";
         if(power<0.3)power2="Low";
         ObjectCreate("ML ORDERALLOWpricemovepower",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpricemovepower",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpricemovepower",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpricemovepower",OBJPROP_YDISTANCE,5);
         ObjectSetText("ML ORDERALLOWpricemovepower","Break Power (Price Move) ="+power2,10,"arial",Red);
        }

      if(power2=="High"&& timepower=="High")signalpower=" Strong";
      if(power2=="High" && timepower=="High" && penetrationbreak=="Confirmed")signalpower=" Very Strong (Gold)";

      if(power2=="High" && timepower=="Medium")signalpower=" Strong";
      if(power2=="High" && timepower=="Medium" && penetrationbreak=="Confirmed")signalpower=" Very Strong";

      if(power2=="High" && timepower=="Low")signalpower=" Medium";
      if(power2=="High" && timepower=="Low" && penetrationbreak=="Confirmed")signalpower=" Medium +";

      if(power2=="Medium" && timepower=="High")signalpower=" Strong";
      if(power2=="Medium" && timepower=="High" && penetrationbreak=="Confirmed")signalpower=" Very Strong";

      if(power2=="Medium" && timepower=="Medium")signalpower=" Medium";
      if(power2=="Medium" && timepower=="Medium" && penetrationbreak=="Confirmed")signalpower=" Medium +";

      if(power2=="Medium" && timepower=="Low")signalpower=" Medium";
      if(power2=="Medium" && timepower=="Low" && penetrationbreak=="Confirmed")signalpower=" Medium +";

      if(power2=="Low" && timepower=="High")signalpower=" Medium";
      if(power2=="Low" && timepower=="High" && penetrationbreak=="Confirmed")signalpower=" Medium +";

      if(power2=="Low" && timepower=="Medium")signalpower=" Weak";
      if(power2=="Low" && timepower=="Medium"&& penetrationbreak=="Confirmed")signalpower=" Weak +";

      if(power2=="Low" && timepower=="Low")signalpower="  Very Weak";
      if(power2=="Low" && timepower=="Low" && penetrationbreak=="Confirmed")signalpower=" Very Weak +";

      if(pattern==0)signalpower="No Confirmation(no Signal)";

      if(pattern==1 || pattern==2)
        {
         ObjectCreate("ML ORDERALLOWsignalpower",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWsignalpower",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWsignalpower",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWsignalpower",OBJPROP_YDISTANCE,50);
         ObjectSetText("ML ORDERALLOWsignalpower","Signal Strength ="+signalpower,10,"arial",Blue);
        }
      if(pattern==0)
        {
         ObjectCreate("ML ORDERALLOWsignalpower",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWsignalpower",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWsignalpower",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWsignalpower",OBJPROP_YDISTANCE,50);
         ObjectSetText("ML ORDERALLOWsignalpower","Signal Strength ="+signalpower,10,"arial",Brown);
        }

      if(penetrationbreak=="Confirmed")
        {
         ObjectCreate("ML ORDERALLOWpenetrationbreak",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpenetrationbreak",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpenetrationbreak",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpenetrationbreak",OBJPROP_YDISTANCE,35);
         ObjectSetText("ML ORDERALLOWpenetrationbreak","Break Penetration ="+penetrationbreak,10,"arial",Green);
        }
      if(penetrationbreak=="Not-Confirmed")
        {
         ObjectCreate("ML ORDERALLOWpenetrationbreak",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpenetrationbreak",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpenetrationbreak",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpenetrationbreak",OBJPROP_YDISTANCE,35);
         ObjectSetText("ML ORDERALLOWpenetrationbreak","Break Penetration ="+penetrationbreak,10,"arial",Brown);
        }

      if(pattern==2)
        {
         for(jojo=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q)+14*24*60*60);jojo<=shoro-1; jojo++)
           {
            if(iClose(NULL,PERIOD_H4,jojo)>TL && jojo!=0)
              {
               countcloseup++;
              }
           }
        }

      if(pattern==1)
        {
         for(jojo=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q)+14*24*60*60);jojo<=shoro-1; jojo++)
           {
            if(iClose(NULL,PERIOD_H4,jojo)<LL && jojo!=0)
              {
               countclosedown++;
              }
           }

        }

      int orderallow=1;
      bool deleteresult;
      if(pattern==2)
        {
         for(jojo=shoro-1;jojo>=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q-1)+6*24*60*59.9); jojo--)
           {

            if(iHigh(NULL,PERIOD_H4,jojo)>minTL2 || iLow(NULL,PERIOD_H4,jojo)<minLL2)
              {
               orderallow=0;
              }

           }
        }
      if(pattern==1)
        {
         for(jojo=shoro-1;jojo>=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q-1)+6*24*60*59.9); jojo--)
           {
            if(iLow(NULL,PERIOD_H4,jojo)<minLL2 || iHigh(NULL,PERIOD_H4,jojo)>minTL2)
              {
               orderallow=0;
              }

           }
        }

      if(NOfOrders<2 && orderallow==1 && AllowTrade==true && penetrationbreak=="Confirmed")
        {
         if(NOfOrders<1 && pattern==1 && penetrationbreak=="Confirmed")
           {

            Ticketselldor=OrderSend(Symbol(),OP_SELLLIMIT,LOT,NormalizeDouble(LL+5*((TL-LL)/6),Digits),30,0,0,"Weekly",12,iTime(NULL,PERIOD_W1,q)+12*24*60*62,Red);
            if(Ticketselldor>0)
              {
               Ticketselldormodify=OrderModify(Ticketselldor,NormalizeDouble(LL+5*((TL-LL)/6),Digits),NormalizeDouble(minTL4+20*Point,Digits),NormalizeDouble(minLL3-80*Point,Digits),iTime(NULL,PERIOD_W1,q)+12*24*60*62,White);
              }
           }
        }
      if(NOfOrders<2 && orderallow==1 && AllowTrade==true && penetrationbreak=="Confirmed")
        {
         if(NOfOrders<1 && countclosedown>=2 && pattern==1 && penetrationbreak=="Confirmed")
           {
            Ticketsellmiani=OrderSend(Symbol(),OP_SELLLIMIT,LOT,NormalizeDouble(LL+3.7*((TL-LL)/6),Digits),30,0,0,"Weekly",12,iTime(NULL,PERIOD_W1,q)+12*24*60*62,Red);
            if(Ticketsellmiani>0)
              {
               Ticketsellmianimodify=OrderModify(Ticketsellmiani,NormalizeDouble(LL+3.7*((TL-LL)/6),Digits),NormalizeDouble(minTL4+20*Point,Digits),NormalizeDouble(minLL3-80*Point,Digits),iTime(NULL,PERIOD_W1,q)+12*24*60*62,White);

              }
           }
        }
      if(NOfOrders<2 && orderallow==1 && AllowTrade==true && penetrationbreak=="Confirmed")
        {
         if(NOfOrders<1 && pattern==2 && penetrationbreak=="Confirmed")
           {
            Ticketbuydor=OrderSend(Symbol(),OP_BUYLIMIT,LOT,NormalizeDouble(LL+((TL-LL)/6),Digits),30,0,0,"Weekly",12,iTime(NULL,PERIOD_W1,q)+12*24*60*62,Red);

            if(Ticketbuydor>0)
              {
               Ticketbuydormodify=OrderModify(Ticketbuydor,NormalizeDouble(LL+((TL-LL)/6),Digits),NormalizeDouble(minLL4-20*Point,Digits),NormalizeDouble(minTL3+80*Point,Digits),iTime(NULL,PERIOD_W1,q)+12*24*60*62,White);

              }
           }
        }

      if(NOfOrders<2 && orderallow==1 && AllowTrade==true && penetrationbreak=="Confirmed")
        {
         if(NOfOrders<1 && countcloseup>=2 && pattern==2 && penetrationbreak=="Confirmed")
           {
            Ticketbuymiani=OrderSend(Symbol(),OP_BUYLIMIT,LOT,NormalizeDouble(LL+2.3*((TL-LL)/6),Digits),30,0,0,"Weekly",12,iTime(NULL,PERIOD_W1,q)+12*24*60*61,Red);
            if(Ticketbuymiani>0)
              {
               Ticketbuymianimodify=OrderModify(Ticketbuymiani,NormalizeDouble(LL+2.3*((TL-LL)/6),Digits),NormalizeDouble(minLL4-20*Point,Digits),NormalizeDouble(minTL3+80*Point,Digits),iTime(NULL,PERIOD_W1,q)+12*24*60*61,White);

              }
           }
        }

      if(pattern==2)
        {
         for(jojo=shoro-1;jojo>=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q)+14*24*60*60); jojo--)
           {

            if(iHigh(NULL,PERIOD_H4,jojo)>minTL2)
              {
               deleteresult=OrderDelete(Ticketbuymiani);
               deleteresult=OrderDelete(Ticketbuydor);
               deleteresult=OrderDelete(Ticketsellmiani);
               deleteresult=OrderDelete(Ticketselldor);
              }

           }
        }
      if(pattern==1)
        {
         for(jojo=shoro-1;jojo>=iBarShift(NULL,PERIOD_H4,iTime(NULL,PERIOD_W1,q)+14*24*60*60); jojo--)
           {
            if(iLow(NULL,PERIOD_H4,jojo)<minLL2)
              {
               deleteresult=OrderDelete(Ticketbuymiani);
               deleteresult=OrderDelete(Ticketbuydor);
               deleteresult=OrderDelete(Ticketsellmiani);
               deleteresult=OrderDelete(Ticketselldor);
              }

           }
        }

      if(orderallow==0)
        {
         string tradeallow="BE CAREFULL NO TRADE ANY MORE";
         ObjectCreate("ML ORDERALLOW",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOW",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOW",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOW",OBJPROP_YDISTANCE,70);
         ObjectSetText("ML ORDERALLOW",tradeallow,18,"arial",Red);
        }

      //-----------------
      int shoroD1=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_W1,q-1));
      ObjectCreate("ML StartTradeWeekD1",OBJ_VLINE,0,iTime(NULL,PERIOD_D1,shoroD1-1),iOpen(NULL,PERIOD_D1,shoroD1-1));
      ObjectSet("ML StartTradeWeekD1",OBJPROP_STYLE,STYLE_DOT);
      ObjectSet("ML StartTradeWeekD1",OBJPROP_COLOR,Green);
      ObjectSet("ML StartTradeWeekD1",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
     }

   if(typeofanalysis==2 && AllowReverse==true)
     {
      int patternRe;
      int Ticketsellup1;
      int Ticketsellup2;
      int Ticketsellup3;

      int Ticketbuydown1;
      int Ticketbuydown2;
      int Ticketbuydown3;

      bool Ticketsellup1modify;
      bool Ticketsellup2modify;
      bool Ticketsellup3modify;

      bool Ticketbuydown1modify;
      bool Ticketbuydown2modify;
      bool Ticketbuydown3modify;

      int NOfOrdersRe=0;
      int TicketBRe = 0;
      int TicketSRe = 0;
      int TicketBPRe = 0;
      int TicketSPRe = 0;
      for(int iRe=0;iRe<OrdersTotal();iRe++)
        {
         if(OrderSelect(iRe,SELECT_BY_POS)==false)
            return(-1);
         if(OrderSymbol()!=Symbol())
            continue;
         if(OrderMagicNumber()!=66)
            continue;

         if(OrderType()==OP_BUY)TicketBRe=OrderTicket();
         if(OrderType()==OP_SELL)TicketSRe=OrderTicket();
         if(OrderType()==OP_BUYLIMIT)TicketBPRe=OrderTicket();
         if(OrderType()==OP_SELLLIMIT)TicketSPRe=OrderTicket();

         NOfOrdersRe++;
        }


      if(NOfOrdersRe<2 && AllowReverse==true)
        {
         if(NOfOrdersRe<1)
           {
            Ticketsellup1=OrderSend(Symbol(),OP_SELLLIMIT,LOT,NormalizeDouble(TL,Digits),30,0,0,"Reverse Sell",66,iTime(NULL,PERIOD_W1,q)+12*24*60*62,Red);
            if(Ticketsellup1>0)
              {
               Ticketsellup1modify=OrderModify(Ticketsellup1,NormalizeDouble(TL,Digits),NormalizeDouble(minTL4+20*Point,Digits),NormalizeDouble(TL-((TL-LL)/2),Digits),iTime(NULL,PERIOD_W1,q)+12*24*60*62,White);
              }
           }
        }
      if(NOfOrdersRe<2 && AllowReverse==true)
        {
         if(NOfOrdersRe<1)
           {
            Ticketbuydown1=OrderSend(Symbol(),OP_BUYLIMIT,LOT,NormalizeDouble(LL,Digits),30,0,0,"Reverse Buy",66,iTime(NULL,PERIOD_W1,q)+12*24*60*62,Red);

            if(Ticketbuydown1>0)
              {
               Ticketbuydown1modify=OrderModify(Ticketbuydown1,NormalizeDouble(LL,Digits),NormalizeDouble(minLL4-20*Point,Digits),NormalizeDouble(LL+((TL-LL)/2),Digits),iTime(NULL,PERIOD_W1,q)+12*24*60*62,White);
              }

           }
        }

     }
//-------------------------Monthly-------------------------+
//-------------------------Monthly-------------------------+    
   if(typeofanalysis==3)
     {
      int jojomonthly;
      int Ticketselldormonthly;
      int countTicketselldormonthly;
      int Ticketsellmianimonthly;
      int countTicketsellmianimonthly;
      int Ticketbuydormonthly;
      int countTicketbuydormonthly;
      int Ticketbuymianimonthly;
      int countTicketbuymianimonthly;
      bool Ticketselldormodifymonthly;
      bool Ticketsellmianimodifymonthly;
      bool Ticketbuydormodifymonthly;
      bool Ticketbuymianimodifymonthly;

      int NOfOrdersmonthly=0;
      int TicketBmonthly = 0;
      int TicketSmonthly = 0;
      int TicketBPmonthly = 0;
      int TicketSPmonthly = 0;
      for(int imonthly=0;imonthly<OrdersTotal();imonthly++)
        {
         if(OrderSelect(imonthly,SELECT_BY_POS)==false)
            return(-1);
         if(OrderSymbol()!=Symbol())
            continue;
         if(OrderMagicNumber()!=30)
            continue;

         if(OrderType()==OP_BUY)TicketBmonthly=OrderTicket();
         if(OrderType()==OP_SELL)TicketSmonthly=OrderTicket();
         if(OrderType()==OP_BUYLIMIT)TicketBPmonthly=OrderTicket();
         if(OrderType()==OP_SELLLIMIT)TicketSPmonthly=OrderTicket();

         NOfOrdersmonthly++;
        }

      int shoromonthly=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q-1));
      ObjectCreate("ML StartTradeWeekH4Monthly",OBJ_VLINE,0,iTime(NULL,PERIOD_D1,shoromonthly-1),iOpen(NULL,PERIOD_D1,shoromonthly-1));
      ObjectSet("ML StartTradeWeekH4Monthly",OBJPROP_STYLE,STYLE_DOT);
      ObjectSet("ML StartTradeWeekH4Monthly",OBJPROP_COLOR,Green);
      ObjectSet("ML StartTradeWeekH4Monthly",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);

      int breaktimepowermonthly;
      int countcloseupmonthly=0;
      int countclosedownmonthly=0;
      int powerIDmonthly;
      double powerLowmonthly;
      string penetrationbreakmonthly;
      double powerLow2monthly=iOpen(NULL,PERIOD_D1,shoromonthly-1);
      double powerHighmonthly;
      double powerHigh2monthly=iOpen(NULL,PERIOD_D1,shoromonthly-1);
      string timepowermonthly;
      string signalpowermonthly;
      int patternmonthly;
      int jojo3monthly;

      for(jojomonthly=shoromonthly-1;jojomonthly>=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q)+60*24*60*60); jojomonthly--)
        {

         if(iHigh(NULL,PERIOD_D1,jojomonthly)>TLmonthly)
           {
            patternmonthly=2;
            for(powerIDmonthly=shoromonthly-1;powerIDmonthly>=jojomonthly;powerIDmonthly--)
              {
               powerLowmonthly=iLow(NULL,PERIOD_D1,powerIDmonthly);
               if(powerLowmonthly<powerLow2monthly)
                 {
                  powerLow2monthly=powerLowmonthly;
                 }

              }
            break;
           }
         if(iLow(NULL,PERIOD_D1,jojomonthly)<LLmonthly)
           {
            patternmonthly=1;
            for(powerIDmonthly=shoromonthly-1;powerIDmonthly>=jojomonthly;powerIDmonthly--)
              {
               powerHighmonthly=iHigh(NULL,PERIOD_D1,powerIDmonthly);
               if(powerHighmonthly>powerHigh2monthly)
                 {
                  powerHigh2monthly=powerHighmonthly;
                 }

              }
            break;
           }

        }

      if(patternmonthly==2)
        {
         for(jojo3monthly=shoromonthly-1;jojo3monthly>=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q)+60*24*60*60); jojo3monthly--)
           {

            if(iHigh(NULL,PERIOD_D1,jojo3monthly)<minTL3monthly && iHigh(NULL,PERIOD_D1,jojo3monthly)>TLmonthly)
              {
               penetrationbreakmonthly="Not-Confirmed";
              }

            if(iHigh(NULL,PERIOD_D1,jojo3monthly)>minTL3monthly && iHigh(NULL,PERIOD_D1,jojo3monthly)>TLmonthly)
              {
               penetrationbreakmonthly="Confirmed";
              }

            if(penetrationbreakmonthly=="Confirmed") break;
           }
        }
      if(patternmonthly==1)
        {
         for(jojo3monthly=shoromonthly-1;jojo3monthly>=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q)+60*24*60*60); jojo3monthly--)
           {
            if(iLow(NULL,PERIOD_D1,jojo3monthly)>minLL3monthly && iLow(NULL,PERIOD_D1,jojo3monthly)<LLmonthly)
              {
               penetrationbreakmonthly="Not-Confirmed";
              }

            if(iLow(NULL,PERIOD_D1,jojo3monthly)<minLL3monthly && iLow(NULL,PERIOD_D1,jojo3monthly)<LLmonthly)
              {
               penetrationbreakmonthly="Confirmed";
              }

            if(penetrationbreakmonthly=="Confirmed") break;
           }
        }

      if(patternmonthly==1 || patternmonthly==2)
        {
         breaktimepowermonthly=shoromonthly-jojomonthly;
         if(breaktimepowermonthly<=7)timepowermonthly="High";
         if(breaktimepowermonthly>7 && breaktimepowermonthly<=14)timepowermonthly="Medium";
         if(breaktimepowermonthly>14)timepowermonthly="Low";
         ObjectCreate("ML ORDERALLOWtimepowermonthly",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWtimepowermonthly",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWtimepowermonthly",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWtimepowermonthly",OBJPROP_YDISTANCE,20);
         ObjectSetText("ML ORDERALLOWtimepowermonthly","Break Power (Time Break) ="+timepowermonthly,10,"arial",Red);
        }
      double powermonthly;
      string power2monthly;
      if(patternmonthly==2)
        {
         powermonthly=NormalizeDouble(((TLmonthly-powerLow2monthly)/(TLmonthly-LLmonthly)),2);
         if(powermonthly>=0.6)power2monthly="High";
         if(powermonthly<0.6 && powermonthly>=0.3)power2monthly="Medium";
         if(powermonthly<0.3)power2monthly="Low";
         ObjectCreate("ML ORDERALLOWpricemovepowermonthly",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpricemovepowermonthly",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpricemovepowermonthly",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpricemovepowermonthly",OBJPROP_YDISTANCE,5);
         ObjectSetText("ML ORDERALLOWpricemovepowermonthly","Break Power (Price Move) ="+power2monthly,10,"arial",Red);
        }
      if(patternmonthly==1)
        {
         powermonthly=NormalizeDouble(((powerHigh2monthly-LLmonthly)/(TLmonthly-LLmonthly)),2);
         if(powermonthly>=0.6)power2monthly="High";
         if(powermonthly<0.6 && powermonthly>=0.3)power2monthly="Medium";
         if(powermonthly<0.3)power2monthly="Low";
         ObjectCreate("ML ORDERALLOWpricemovepowermonthly",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpricemovepowermonthly",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpricemovepowermonthly",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpricemovepowermonthly",OBJPROP_YDISTANCE,5);
         ObjectSetText("ML ORDERALLOWpricemovepowermonthly","Break Power (Price Move) ="+power2monthly,10,"arial",Red);
        }

      if(power2monthly=="High" && timepowermonthly=="High")signalpowermonthly=" Strong";
      if(power2monthly=="High" && timepowermonthly=="High" && penetrationbreakmonthly=="Confirmed")signalpowermonthly=" Very Strong (Gold)";

      if(power2monthly=="High" && timepowermonthly=="Medium")signalpowermonthly=" Strong";
      if(power2monthly=="High" && timepowermonthly=="Medium" && penetrationbreakmonthly=="Confirmed")signalpowermonthly=" Very Strong";

      if(power2monthly=="High" && timepowermonthly=="Low")signalpowermonthly=" Medium";
      if(power2monthly=="High" && timepowermonthly=="Low" && penetrationbreakmonthly=="Confirmed")signalpowermonthly=" Medium +";

      if(power2monthly=="Medium" && timepowermonthly=="High")signalpowermonthly=" Strong";
      if(power2monthly=="Medium" && timepowermonthly=="High" && penetrationbreakmonthly=="Confirmed")signalpowermonthly=" Very Strong";

      if(power2monthly=="Medium" && timepowermonthly=="Medium")signalpowermonthly=" Medium";
      if(power2monthly=="Medium" && timepowermonthly=="Medium" && penetrationbreakmonthly=="Confirmed")signalpowermonthly=" Medium +";

      if(power2monthly=="Medium" && timepowermonthly=="Low")signalpowermonthly=" Medium";
      if(power2monthly=="Medium" && timepowermonthly=="Low" && penetrationbreakmonthly=="Confirmed")signalpowermonthly=" Medium +";

      if(power2monthly=="Low" && timepowermonthly=="High")signalpowermonthly=" Medium";
      if(power2monthly=="Low" && timepowermonthly=="High" && penetrationbreakmonthly=="Confirmed")signalpowermonthly=" Medium +";

      if(power2monthly=="Low" && timepowermonthly=="Medium")signalpowermonthly=" Weak";
      if(power2monthly=="Low" && timepowermonthly=="Medium"&& penetrationbreakmonthly=="Confirmed")signalpowermonthly=" Weak +";

      if(power2monthly=="Low" && timepowermonthly=="Low")signalpowermonthly="  Very Weak";
      if(power2monthly=="Low" && timepowermonthly=="Low" && penetrationbreakmonthly=="Confirmed")signalpowermonthly=" Very Weak +";

      if(patternmonthly==0)signalpowermonthly="No Confirmation(no Signal)";

      if(patternmonthly==1 || patternmonthly==2)
        {
         ObjectCreate("ML ORDERALLOWsignalpowermonthly",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWsignalpowermonthly",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWsignalpowermonthly",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWsignalpowermonthly",OBJPROP_YDISTANCE,50);
         ObjectSetText("ML ORDERALLOWsignalpowermonthly","Signal Strength ="+signalpowermonthly,10,"arial",Blue);
        }
      if(patternmonthly==0)
        {
         ObjectCreate("ML ORDERALLOWsignalpowermonthly",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWsignalpowermonthly",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWsignalpowermonthly",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWsignalpowermonthly",OBJPROP_YDISTANCE,50);
         ObjectSetText("ML ORDERALLOWsignalpowermonthly","Signal Strength ="+signalpowermonthly,10,"arial",Brown);
        }

      if(penetrationbreakmonthly=="Confirmed")
        {
         ObjectCreate("ML ORDERALLOWpenetrationbreakmonthly",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpenetrationbreakmonthly",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpenetrationbreakmonthly",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpenetrationbreakmonthly",OBJPROP_YDISTANCE,35);
         ObjectSetText("ML ORDERALLOWpenetrationbreakmonthly","Break Penetration ="+penetrationbreakmonthly,10,"arial",Green);
        }
      if(penetrationbreakmonthly=="Not-Confirmed")
        {
         ObjectCreate("ML ORDERALLOWpenetrationbreakmonthly",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpenetrationbreakmonthly",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpenetrationbreakmonthly",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpenetrationbreakmonthly",OBJPROP_YDISTANCE,35);
         ObjectSetText("ML ORDERALLOWpenetrationbreakmonthly","Break Penetration ="+penetrationbreakmonthly,10,"arial",Brown);
        }

      if(patternmonthly==2)
        {
         for(jojomonthly=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q)+60*24*60*60);jojomonthly<=shoromonthly-1; jojomonthly++)
           {
            if(iClose(NULL,PERIOD_D1,jojomonthly)>TLmonthly && jojomonthly!=0)
              {
               countcloseupmonthly++;
              }
           }
        }

      if(patternmonthly==1)
        {
         for(jojomonthly=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q)+60*24*60*60);jojomonthly<=shoromonthly-1; jojomonthly++)
           {
            if(iClose(NULL,PERIOD_D1,jojomonthly)<LLmonthly && jojomonthly!=0)
              {
               countclosedownmonthly++;
              }
           }

        }

      int orderallowmonthly=1;
      bool deleteresultmonthly;
      if(patternmonthly==2)
        {
         for(jojomonthly=shoromonthly-1;jojomonthly>=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q-1)+60*24*60*60); jojomonthly--)
           {

            if(iHigh(NULL,PERIOD_D1,jojomonthly)>minTL2monthly)
              {
               orderallowmonthly=0;
              }

           }
        }
      if(patternmonthly==1)
        {
         for(jojomonthly=shoromonthly-1;jojomonthly>=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q)+60*24*60*60); jojomonthly--)
           {
            if(iLow(NULL,PERIOD_D1,jojomonthly)<minLL2monthly)
              {
               orderallowmonthly=0;
              }

           }
        }

      if(NOfOrdersmonthly<2 && orderallowmonthly==1 && AllowTrade==true && penetrationbreakmonthly=="Confirmed")
        {
         if(NOfOrdersmonthly<1 && patternmonthly==1 && penetrationbreakmonthly=="Confirmed")
           {
            Ticketselldormonthly=OrderSend(Symbol(),OP_SELLLIMIT,LOT,NormalizeDouble(LLmonthly+5*((TLmonthly-LLmonthly)/6),Digits),30,0,0,"Monthly",30,iTime(NULL,PERIOD_MN1,q)+55*24*60*62,Red);
            if(Ticketselldormonthly>0)
              {
               Ticketselldormodifymonthly=OrderModify(Ticketselldormonthly,NormalizeDouble(LLmonthly+5*((TLmonthly-LLmonthly)/6),Digits),NormalizeDouble(minTL4monthly+20*Point,Digits),NormalizeDouble(minLL3monthly-80*Point,Digits),iTime(NULL,PERIOD_MN1,q)+55*24*60*62,White);

              }
           }
        }

      if(NOfOrdersmonthly<2 && orderallowmonthly==1 && AllowTrade==true && penetrationbreakmonthly=="Confirmed")
        {

         if(NOfOrdersmonthly<1 && countclosedownmonthly>=2 && patternmonthly==1 && penetrationbreakmonthly=="Confirmed")
           {
            Ticketsellmianimonthly=OrderSend(Symbol(),OP_SELLLIMIT,LOT,NormalizeDouble(LLmonthly+3.7*((TLmonthly-LLmonthly)/6),Digits),30,0,0,"Monthly",30,iTime(NULL,PERIOD_MN1,q)+55*24*60*62,Red);
            if(Ticketsellmianimonthly>0)
              {
               Ticketsellmianimodifymonthly=OrderModify(Ticketsellmianimonthly,NormalizeDouble(LLmonthly+3.7*((TLmonthly-LLmonthly)/6),Digits),NormalizeDouble(minTL4monthly+20*Point,Digits),NormalizeDouble(minLL3monthly-80*Point,Digits),iTime(NULL,PERIOD_MN1,q)+55*24*60*62,White);

              }
           }
        }

      if(NOfOrdersmonthly<2 && orderallowmonthly==1 && AllowTrade==true && penetrationbreakmonthly=="Confirmed")
        {
         if(NOfOrdersmonthly<1 && patternmonthly==2 && penetrationbreakmonthly=="Confirmed")
           {
            Ticketbuydormonthly=OrderSend(Symbol(),OP_BUYLIMIT,LOT,NormalizeDouble(LLmonthly+((TLmonthly-LLmonthly)/6),Digits),30,0,0,"Monthly",30,iTime(NULL,PERIOD_MN1,q)+55*24*60*62,Red);
            if(Ticketbuydormonthly>0)
              {
               Ticketbuydormodifymonthly=OrderModify(Ticketbuydormonthly,NormalizeDouble(LLmonthly+((TLmonthly-LLmonthly)/6),Digits),NormalizeDouble(minLL4monthly-20*Point,Digits),NormalizeDouble(minTL3monthly+80*Point,Digits),iTime(NULL,PERIOD_MN1,q)+55*24*60*62,White);

              }
           }
        }

      if(NOfOrdersmonthly<2 && orderallowmonthly==1 && AllowTrade==true && penetrationbreakmonthly=="Confirmed")
        {

         if(NOfOrdersmonthly<1 && countcloseupmonthly>=2 && patternmonthly==2 && penetrationbreakmonthly=="Confirmed")
           {
            Ticketbuymianimonthly=OrderSend(Symbol(),OP_BUYLIMIT,LOT,NormalizeDouble(LLmonthly+2.3*((TLmonthly-LLmonthly)/6),Digits),30,0,0,"Monthly",30,iTime(NULL,PERIOD_MN1,q)+55*24*60*61,Red);
            if(Ticketbuymianimonthly>0)
              {
               Ticketbuymianimodifymonthly=OrderModify(Ticketbuymianimonthly,NormalizeDouble(LLmonthly+2.3*((TLmonthly-LLmonthly)/6),Digits),NormalizeDouble(minLL4monthly-20*Point,Digits),NormalizeDouble(minTL3monthly+80*Point,Digits),iTime(NULL,PERIOD_MN1,q)+55*24*60*61,White);

              }
           }
        }

      if(patternmonthly==2)
        {
         for(jojomonthly=shoromonthly-1;jojo>=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q)+60*24*60*60); jojomonthly--)
           {

            if(iHigh(NULL,PERIOD_D1,jojomonthly)>minTL2monthly)
              {
               deleteresultmonthly=OrderDelete(Ticketbuymianimonthly);
               deleteresultmonthly=OrderDelete(Ticketbuydormonthly);
               deleteresultmonthly=OrderDelete(Ticketsellmianimonthly);
               deleteresultmonthly=OrderDelete(Ticketselldormonthly);
              }

           }
        }
      if(patternmonthly==1)
        {
         for(jojomonthly=shoromonthly-1;jojomonthly>=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q)+60*24*60*60); jojomonthly--)
           {
            if(iLow(NULL,PERIOD_D1,jojomonthly)<minLL2monthly)
              {
               deleteresultmonthly=OrderDelete(Ticketbuymianimonthly);
               deleteresultmonthly=OrderDelete(Ticketbuydormonthly);
               deleteresultmonthly=OrderDelete(Ticketsellmianimonthly);
               deleteresultmonthly=OrderDelete(Ticketselldormonthly);
              }

           }
        }

      if(orderallowmonthly==0)
        {
         string tradeallowmonthly="BE CAREFULL NO TRADE ANY MORE";
         ObjectCreate("ML ORDERALLOWmonthly",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWmonthly",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWmonthly",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWmonthly",OBJPROP_YDISTANCE,70);
         ObjectSetText("ML ORDERALLOWmonthly",tradeallowmonthly,18,"arial",Red);
        }

     }
//-------------------------Daily-------------------------+    
   if(typeofanalysis==1)
     {
      int jojodaily;
      int Ticketselldordaily;
      int countTicketselldordaily;
      int Ticketsellmianidaily;
      int countTicketsellmianidaily;
      int Ticketbuydordaily;
      int countTicketbuydordaily;
      int Ticketbuymianidaily;
      int countTicketbuymianidaily;
      bool Ticketselldormodifydaily;
      bool Ticketsellmianimodifydaily;
      bool Ticketbuydormodifydaily;
      bool Ticketbuymianimodifydaily;

      int NOfOrdersdaily=0;
      int TicketBdaily = 0;
      int TicketSdaily = 0;
      int TicketBPdaily = 0;
      int TicketSPdaily = 0;
      for(int idaily=0;idaily<OrdersTotal();idaily++)
        {
         if(OrderSelect(idaily,SELECT_BY_POS)==false)
            return(-1);
         if(OrderSymbol()!=Symbol())
            continue;
         if(OrderMagicNumber()!=24)
            continue;

         if(OrderType()==OP_BUY)TicketBdaily=OrderTicket();
         if(OrderType()==OP_SELL)TicketSdaily=OrderTicket();
         if(OrderType()==OP_BUYLIMIT)TicketBPdaily=OrderTicket();
         if(OrderType()==OP_SELLLIMIT)TicketSPdaily=OrderTicket();

         NOfOrdersdaily++;
        }

      int shorodaily=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q-1));
      ObjectCreate("ML StartTradeWeekH4daily",OBJ_VLINE,0,iTime(NULL,PERIOD_H1,shorodaily-1),iOpen(NULL,PERIOD_H1,shorodaily-1));
      ObjectSet("ML StartTradeWeekH4daily",OBJPROP_STYLE,STYLE_DOT);
      ObjectSet("ML StartTradeWeekH4daily",OBJPROP_COLOR,Green);
      ObjectSet("ML StartTradeWeekH4daily",OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);

      int breaktimepowerdaily;
      int countcloseupdaily=0;
      int countclosedowndaily=0;
      int powerIDdaily;
      double powerLowdaily;
      string penetrationbreakdaily;
      double powerLow2daily=iOpen(NULL,PERIOD_H1,shorodaily-1);
      double powerHighdaily;
      double powerHigh2daily=iOpen(NULL,PERIOD_H1,shorodaily-1);
      string timepowerdaily;
      string signalpowerdaily;
      int patterndaily;
      int jojo3daily;

      for(jojodaily=shorodaily-1;jojodaily>=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q-1)+1*24*60*60); jojodaily--)
        {

         if(iHigh(NULL,PERIOD_H1,jojodaily)>TLdaily)
           {
            patterndaily=2;
            for(powerIDdaily=shorodaily-1;powerIDdaily>=jojodaily;powerIDdaily--)
              {
               powerLowdaily=iLow(NULL,PERIOD_H1,powerIDdaily);
               if(powerLowdaily<powerLow2daily)
                 {
                  powerLow2daily=powerLowdaily;
                 }
              }
            break;
           }
         if(iLow(NULL,PERIOD_H1,jojodaily)<LLdaily)
           {
            patterndaily=1;
            for(powerIDdaily=shorodaily-1;powerIDdaily>=jojodaily;powerIDdaily--)
              {
               powerHighdaily=iHigh(NULL,PERIOD_H1,powerIDdaily);
               if(powerHighdaily>powerHigh2daily)
                 {
                  powerHigh2daily=powerHighdaily;
                 }

              }
            break;
           }

        }

      if(patterndaily==2)
        {
         for(jojo3daily=shorodaily-1;jojo3daily>=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q-1)+1*24*60*60); jojo3daily--)
           {

            if(iHigh(NULL,PERIOD_H1,jojo3daily)<minTL3daily && iHigh(NULL,PERIOD_H1,jojo3daily)>TLdaily)
              {
               penetrationbreakdaily="Not-Confirmed";
              }

            if(iHigh(NULL,PERIOD_H1,jojo3daily)>minTL3daily && iHigh(NULL,PERIOD_H1,jojo3daily)>TLdaily)
              {
               penetrationbreakdaily="Confirmed";
              }

            if(penetrationbreakdaily=="Confirmed") break;

           }
        }

      if(patterndaily==1)
        {
         for(jojo3daily=shorodaily-1;jojo3daily>=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q-1)+1*24*60*60); jojo3daily--)
           {

            if(iLow(NULL,PERIOD_H1,jojo3daily)>minLL3daily && iLow(NULL,PERIOD_H1,jojo3daily)<LLdaily)
              {
               penetrationbreakdaily="Not-Confirmed";
              }

            if(iLow(NULL,PERIOD_H1,jojo3daily)<minLL3daily && iLow(NULL,PERIOD_H1,jojo3daily)<LLdaily)
              {
               penetrationbreakdaily="Confirmed";
              }

            if(penetrationbreakdaily=="Confirmed") break;
           }
        }

      if(patterndaily==1 || patterndaily==2)
        {
         breaktimepowerdaily=shorodaily-jojodaily;
         if(breaktimepowerdaily<=8)timepowerdaily="High";
         if(breaktimepowerdaily>8 && breaktimepowerdaily<=16)timepowerdaily="Medium";
         if(breaktimepowerdaily>16)timepowerdaily="Low";
         ObjectCreate("ML ORDERALLOWtimepowerdaily",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWtimepowerdaily",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWtimepowerdaily",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWtimepowerdaily",OBJPROP_YDISTANCE,20);
         ObjectSetText("ML ORDERALLOWtimepowerdaily","Break Power (Time Break) ="+timepowerdaily,10,"arial",Red);
        }
      double powerdaily;
      string power2daily;
      if(patterndaily==2)
        {
         powerdaily=NormalizeDouble(((TLdaily-powerLow2daily)/(TLdaily-LLdaily)),2);
         if(powerdaily>=0.6)power2daily="High";
         if(powerdaily<0.6 && powerdaily>=0.3)power2daily="Medium";
         if(powerdaily<0.3)power2daily="Low";
         ObjectCreate("ML ORDERALLOWpricemovepowerdaily",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpricemovepowerdaily",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpricemovepowerdaily",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpricemovepowerdaily",OBJPROP_YDISTANCE,5);
         ObjectSetText("ML ORDERALLOWpricemovepowerdaily","Break Power (Price Move) ="+power2daily,10,"arial",Red);
        }
      if(patterndaily==1)
        {
         powerdaily=NormalizeDouble(((powerHigh2daily-LLdaily)/(TLdaily-LLdaily)),2);
         if(powerdaily>=0.6)power2daily="High";
         if(powerdaily<0.6 && powerdaily>=0.3)power2daily="Medium";
         if(powerdaily<0.3)power2daily="Low";
         ObjectCreate("ML ORDERALLOWpricemovepowerdaily",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpricemovepowerdaily",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpricemovepowerdaily",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpricemovepowerdaily",OBJPROP_YDISTANCE,5);
         ObjectSetText("ML ORDERALLOWpricemovepowerdaily","Break Power (Price Move) ="+power2daily,10,"arial",Red);
        }

      if(power2daily=="High" && timepowerdaily=="High")signalpowerdaily=" Strong";
      if(power2daily=="High" && timepowerdaily=="High" && penetrationbreakdaily=="Confirmed")signalpowerdaily=" Very Strong (Gold)";

      if(power2daily=="High" && timepowerdaily=="Medium")signalpowerdaily=" Strong";
      if(power2daily=="High" && timepowerdaily=="Medium" && penetrationbreakdaily=="Confirmed")signalpowerdaily=" Very Strong";

      if(power2daily=="High" && timepowerdaily=="Low")signalpowerdaily=" Medium";
      if(power2daily=="High" && timepowerdaily=="Low" && penetrationbreakdaily=="Confirmed")signalpowerdaily=" Medium +";

      if(power2daily=="Medium" && timepowerdaily=="High")signalpowerdaily=" Strong";
      if(power2daily=="Medium" && timepowerdaily=="High" && penetrationbreakdaily=="Confirmed")signalpowerdaily=" Very Strong";

      if(power2daily=="Medium" && timepowerdaily=="Medium")signalpowerdaily=" Medium";
      if(power2daily=="Medium" && timepowerdaily=="Medium" && penetrationbreakdaily=="Confirmed")signalpowerdaily=" Medium +";

      if(power2daily=="Medium" && timepowerdaily=="Low")signalpowerdaily=" Medium";
      if(power2daily=="Medium" && timepowerdaily=="Low" && penetrationbreakdaily=="Confirmed")signalpowerdaily=" Medium +";

      if(power2daily=="Low" && timepowerdaily=="High")signalpowerdaily=" Medium";
      if(power2daily=="Low" && timepowerdaily=="High" && penetrationbreakdaily=="Confirmed")signalpowerdaily=" Medium +";

      if(power2daily=="Low" && timepowerdaily=="Medium")signalpowerdaily=" Weak";
      if(power2daily=="Low" && timepowerdaily=="Medium"&& penetrationbreakdaily=="Confirmed")signalpowerdaily=" Weak +";

      if(power2daily=="Low" && timepowerdaily=="Low")signalpowerdaily="  Very Weak";
      if(power2daily=="Low" && timepowerdaily=="Low" && penetrationbreakdaily=="Confirmed")signalpowerdaily=" Very Weak +";

      if(patterndaily==0)signalpowerdaily="No Confirmation(no Signal)";

      if(patterndaily==1 || patterndaily==2)
        {
         ObjectCreate("ML ORDERALLOWsignalpowerdaily",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWsignalpowerdaily",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWsignalpowerdaily",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWsignalpowerdaily",OBJPROP_YDISTANCE,50);
         ObjectSetText("ML ORDERALLOWsignalpowerdaily","Signal Strength ="+signalpowerdaily,10,"arial",Blue);
        }
      if(patterndaily==0)
        {
         ObjectCreate("ML ORDERALLOWsignalpowerdaily",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWsignalpowerdaily",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWsignalpowerdaily",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWsignalpowerdaily",OBJPROP_YDISTANCE,50);
         ObjectSetText("ML ORDERALLOWsignalpowerdaily","Signal Strength ="+signalpowerdaily,10,"arial",Brown);
        }

      if(penetrationbreakdaily=="Confirmed")
        {
         ObjectCreate("ML ORDERALLOWpenetrationbreakdaily",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpenetrationbreakdaily",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpenetrationbreakdaily",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpenetrationbreakdaily",OBJPROP_YDISTANCE,35);
         ObjectSetText("ML ORDERALLOWpenetrationbreakdaily","Break Penetration ="+penetrationbreakdaily,10,"arial",Green);
        }
      if(penetrationbreakdaily=="Not-Confirmed")
        {
         ObjectCreate("ML ORDERALLOWpenetrationbreakdaily",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWpenetrationbreakdaily",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWpenetrationbreakdaily",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWpenetrationbreakdaily",OBJPROP_YDISTANCE,35);
         ObjectSetText("ML ORDERALLOWpenetrationbreakdaily","Break Penetration ="+penetrationbreakdaily,10,"arial",Brown);
        }

      if(patterndaily==2)
        {
         for(jojodaily=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q)+1*24*60*60);jojodaily<=shorodaily-1; jojodaily++)
           {
            if(iClose(NULL,PERIOD_H1,jojodaily)>TLdaily && jojodaily!=0)
              {
               countcloseupdaily++;
              }
           }
        }

      if(patterndaily==1)
        {
         for(jojodaily=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q)+1*24*60*60);jojodaily<=shorodaily-1; jojodaily++)
           {
            if(iClose(NULL,PERIOD_H1,jojodaily)<LLdaily && jojodaily!=0)
              {
               countclosedowndaily++;
              }
           }

        }

      int orderallowdaily=1;
      bool deleteresultdaily;
      if(patterndaily==2)
        {
         for(jojodaily=shorodaily-1;jojodaily>=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q-1)+1*24*60*60); jojodaily--)
           {

            if(iHigh(NULL,PERIOD_H1,jojodaily)>minTL2daily && jojodaily!=0)
              {
               orderallowdaily=0;
              }

           }
        }
      if(patterndaily==1)
        {
         for(jojodaily=shorodaily-1;jojodaily>=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q-1)+1*24*60*60); jojodaily--)
           {
            if(iLow(NULL,PERIOD_H1,jojodaily)<minLL2daily && jojodaily!=0)
              {
               orderallowdaily=0;
              }

           }
        }

      if(NOfOrdersdaily<2 && orderallowdaily==1 && AllowTrade==true && penetrationbreakdaily=="Confirmed")
        {
         if(NOfOrdersdaily<1 && patterndaily==1 && penetrationbreakdaily=="Confirmed")
           {

            Ticketselldordaily=OrderSend(Symbol(),OP_SELLLIMIT,LOT,NormalizeDouble(LLdaily+5*((TLdaily-LLdaily)/6),Digits),30,0,0,"daily",24,iTime(NULL,PERIOD_D1,q-1)+2*24*60*58,Red);
            if(Ticketselldordaily>0)
              {
               Ticketselldormodifydaily=OrderModify(Ticketselldordaily,NormalizeDouble(LLdaily+5*((TLdaily-LLdaily)/6),Digits),NormalizeDouble(minTL4daily+20*Point,Digits),NormalizeDouble(minLL3daily-80*Point,Digits),iTime(NULL,PERIOD_D1,q-1)+2*24*60*58,White);

              }
           }
        }

      if(NOfOrdersdaily<2 && orderallowdaily==1 && AllowTrade==true && penetrationbreakdaily=="Confirmed")
        {
         if(NOfOrdersdaily<1 && countclosedowndaily>=2 && patterndaily==1 && penetrationbreakdaily=="Confirmed")
           {
            Ticketsellmianidaily=OrderSend(Symbol(),OP_SELLLIMIT,LOT,NormalizeDouble(LLdaily+3.7*((TLdaily-LLdaily)/6),Digits),30,0,0,"daily",24,iTime(NULL,PERIOD_D1,q-1)+2*24*60*58,Red);
            if(Ticketsellmianidaily>0)
              {
               Ticketsellmianimodifydaily=OrderModify(Ticketsellmianidaily,NormalizeDouble(LLdaily+3.7*((TLdaily-LLdaily)/6),Digits),NormalizeDouble(minTL4daily+20*Point,Digits),NormalizeDouble(minLL3daily-80*Point,Digits),iTime(NULL,PERIOD_D1,q-1)+2*24*60*58,White);

              }
           }
        }

      if(NOfOrdersdaily<2 && orderallowdaily==1 && AllowTrade==true && penetrationbreakdaily=="Confirmed")
        {
         if(NOfOrdersdaily<1 && patterndaily==2 && penetrationbreakdaily=="Confirmed")
           {
            Ticketbuydordaily=OrderSend(Symbol(),OP_BUYLIMIT,LOT,NormalizeDouble(LLdaily+((TLdaily-LLdaily)/6),Digits),30,0,0,"daily",24,iTime(NULL,PERIOD_D1,q-1)+2*24*60*58,Red);
            if(Ticketbuydordaily>0)
              {
               Ticketbuydormodifydaily=OrderModify(Ticketbuydordaily,NormalizeDouble(LLdaily+((TLdaily-LLdaily)/6),Digits),NormalizeDouble(minLL4daily-20*Point,Digits),NormalizeDouble(minTL3daily+80*Point,Digits),iTime(NULL,PERIOD_D1,q-1)+2*24*60*58,White);

              }
           }
        }

      if(NOfOrdersdaily<2 && orderallowdaily==1 && AllowTrade==true && penetrationbreakdaily=="Confirmed")
        {
         if(NOfOrdersdaily<1 && countcloseupdaily>=2 && patterndaily==2 && penetrationbreakdaily=="Confirmed")
           {
            Ticketbuymianidaily=OrderSend(Symbol(),OP_BUYLIMIT,LOT,NormalizeDouble(LLdaily+2.3*((TLdaily-LLdaily)/6),Digits),30,0,0,"daily",24,iTime(NULL,PERIOD_D1,q)+2*24*60*58,Red);
            if(Ticketbuymianidaily>0)
              {
               Ticketbuymianimodifydaily=OrderModify(Ticketbuymianidaily,NormalizeDouble(LLdaily+2.3*((TLdaily-LLdaily)/6),Digits),NormalizeDouble(minLL4daily-20*Point,Digits),NormalizeDouble(minTL3daily+80*Point,Digits),iTime(NULL,PERIOD_D1,q-1)+2*24*60*58,White);
              }
           }
        }

      if(patterndaily==2)
        {
         for(jojodaily=shorodaily-1;jojo>=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q-1)+2*24*60*60); jojodaily--)
           {

            if(iHigh(NULL,PERIOD_H1,jojodaily)>minTL2daily)
              {
               deleteresultdaily=OrderDelete(Ticketbuymianidaily);
               deleteresultdaily=OrderDelete(Ticketbuydordaily);
               deleteresultdaily=OrderDelete(Ticketsellmianidaily);
               deleteresultdaily=OrderDelete(Ticketselldordaily);
              }

           }
        }
      if(patterndaily==1)
        {
         for(jojodaily=shorodaily-1;jojodaily>=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q-1)+2*24*60*60); jojodaily--)
           {
            if(iLow(NULL,PERIOD_H1,jojodaily)<minLL2daily)
              {
               deleteresultdaily=OrderDelete(Ticketbuymianidaily);
               deleteresultdaily=OrderDelete(Ticketbuydordaily);
               deleteresultdaily=OrderDelete(Ticketsellmianidaily);
               deleteresultdaily=OrderDelete(Ticketselldordaily);
              }

           }
        }

      if(orderallowdaily==0)
        {
         string tradeallowdaily="BE CAREFULL NO TRADE ANY MORE";
         ObjectCreate("ML ORDERALLOWdaily",OBJ_LABEL,0,0,0,0,0);
         ObjectSet("ML ORDERALLOWdaily",OBJPROP_CORNER,0);
         ObjectSet("ML ORDERALLOWdaily",OBJPROP_XDISTANCE,400);
         ObjectSet("ML ORDERALLOWdaily",OBJPROP_YDISTANCE,70);
         ObjectSetText("ML ORDERALLOWdaily",tradeallowdaily,18,"arial",Red);
        }

     }

   double current_TL=NormalizeDouble(ObjectGet("ML TL",1),5);
   double current_TL2= NormalizeDouble(ObjectGet("ML TL2",1),5);
   double current_LL = NormalizeDouble(ObjectGet("ML LL",1),5);
   double current_LL2= NormalizeDouble(ObjectGet("ML LL2",1),5);
   double current_F033 = NormalizeDouble(ObjectGet("ML First 0.33",1),5);
   double current_S033 = NormalizeDouble(ObjectGet("ML Second 0.33",1),5);

   double current_TL4x=NormalizeDouble(ObjectGet("ML TL4x",1),5);
   double current_TL3x=NormalizeDouble(ObjectGet("ML TL3x",1),5);
   double current_LL3Q= NormalizeDouble(ObjectGet("ML LL3Q",1),5);
   double current_LL4Q= NormalizeDouble(ObjectGet("ML LL4Q",1),5);

   double current_TL4xmonthly=NormalizeDouble(ObjectGet("ML TL4xmonthly",1),5);
   double current_TL3xmonthly=NormalizeDouble(ObjectGet("ML TL3xmonthly",1),5);
   double current_LL3Qmonthly= NormalizeDouble(ObjectGet("ML LL3Qmonthly",1),5);
   double current_LL4Qmonthly= NormalizeDouble(ObjectGet("ML LL4Qmonthly",1),5);

   double current_TL4xdaily=NormalizeDouble(ObjectGet("ML TL4xdaily",1),5);
   double current_TL3xdaily=NormalizeDouble(ObjectGet("ML TL3xdaily",1),5);
   double current_LL3Qdaily= NormalizeDouble(ObjectGet("ML LL3Qdaily",1),5);
   double current_LL4Qdaily= NormalizeDouble(ObjectGet("ML LL4Qdaily",1),5);
//+------------------------------------------------------------------+
//|                                                                       |
//+------------------------------------------------------------------+
   if(typeofanalysis==2)
     {
      if(current_TL!=TL) TL=current_TL;
      if(current_LL!=LL)LL=current_LL;
      if(current_TL4x!=minTL4)minTL4=current_TL4x;
      if(current_TL3x!=minTL3)minTL3=current_TL3x;
      if(current_TL2!=minTL2)TL2=current_TL2;
      if(current_LL2!=minLL2)LL2=current_LL2;
      if(current_LL3Q!=minLL3)minLL3=current_LL3Q;
      if(current_LL4Q!=minLL4)minLL4=current_LL4Q;
      if(current_F033!=Firstinline)Firstinline=current_LL+((current_TL-current_LL)/3);
      if(current_S033!=Secondinline)Secondinline=current_LL+(2*(current_TL-current_LL)/3);
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(typeofanalysis==3)
     {
      if(current_TL!=TLmonthly) TLmonthly=current_TL;
      if(current_LL!=LLmonthly)LLmonthly=current_LL;
      if(current_TL4xmonthly!=minTL4monthly)minTL4monthly=current_TL4xmonthly;
      if(current_TL3xmonthly!=minTL3monthly)minTL3monthly=current_TL3xmonthly;
      if(current_TL2!=minTL2)TL2=current_TL2;
      if(current_LL2!=minLL2)LL2=current_LL2;
      if(current_LL3Qmonthly!=minLL3monthly)minLL3monthly=current_LL3Qmonthly;
      if(current_LL4Qmonthly!=minLL4monthly)minLL4monthly=current_LL4Qmonthly;
      if(current_F033!=Firstinlinemonthly)Firstinlinemonthly=current_LL+((current_TL-current_LL)/3);
      if(current_S033!=Secondinlinemonthly)Secondinlinemonthly=current_LL+(2*(current_TL-current_LL)/3);
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(typeofanalysis==1)
     {
      if(current_TL!=TLdaily) TLdaily=current_TL;
      if(current_LL!=LLdaily)LLdaily=current_LL;
      if(current_TL2!=minTL2daily)TL2daily=current_TL2;
      if(current_LL2!=minLL2daily)LL2daily=current_LL2;
      if(current_F033!=Firstinlinedaily)Firstinlinedaily=current_LL+((current_TL-current_LL)/3);
      if(current_S033!=Secondinlinedaily)Secondinlinedaily=current_LL+(2*(current_TL-current_LL)/3);
      if(current_TL4xdaily!=minTL4daily)minTL4daily=current_TL4xdaily;
      if(current_TL3xdaily!=minTL3daily)minTL3daily=current_TL3xdaily;
      if(current_LL3Qdaily!=minLL3daily)minLL3daily=current_LL3Qdaily;
      if(current_LL4Qdaily!=minLL4daily)minLL4daily=current_LL4Qdaily;
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(typeofanalysis==2 && TimeCurrent()>(iTime(NULL,PERIOD_W1,q-1)+6*24*60*59.5))
     {
      for(int iii=0;iii<OrdersTotal();iii++)
        {
         if(OrderSelect(iii,SELECT_BY_POS)==false)
            return(-1);
         if(OrderSymbol()!=Symbol())
            continue;
         if(OrderMagicNumber()!=12)
            continue;
         bool result;
         if(OrderType()==OP_BUY) result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID),30, Red );
         if(OrderType()==OP_SELL) result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK),30, Red );
        }

     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(typeofanalysis==3 && TimeCurrent()>(iTime(NULL,PERIOD_MN1,q-1)+59*24*59.99*60))
     {
      for(int iiii=0;iiii<OrdersTotal();iiii++)
        {
         if(OrderSelect(iiii,SELECT_BY_POS)==false)
            return(-1);
         if(OrderSymbol()!=Symbol())
            continue;
         if(OrderMagicNumber()!=30)
            continue;

         if(OrderType()==OP_BUY) result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID),30, Red );
         if(OrderType()==OP_SELL) result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK),30, Red );

        }

     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(typeofanalysis==1 && TimeCurrent()>(iTime(NULL,PERIOD_D1,q-1)+1*24*60*59))
     {
      for(int iiiii=0;iiiii<OrdersTotal();iiiii++)
        {
         if(OrderSelect(iiiii,SELECT_BY_POS)==false)
            return(-1);
         if(OrderSymbol()!=Symbol())
            continue;
         if(OrderMagicNumber()!=24)
            continue;

         if(OrderType()==OP_BUY) result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID),30, Red );
         if(OrderType()==OP_SELL) result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK),30, Red );

        }

     }

//---         
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   string typeofanalysisstring;
   if(typeofanalysis==1) typeofanalysisstring="Daily";
   if(typeofanalysis==2) typeofanalysisstring="Weekly";
   if(typeofanalysis==3) typeofanalysisstring="Monthly";

   if(demo==false)democode=1;
   if(demo==true)democode=0;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(marketopenclose==0)
     {
      SendNotification(Symbol()+typeofanalysisstring+pp);
     }

//ReadUrl("http://www.kpmteam.ir/ml/mostafa/bla.php?name="+accountname+"&accountnumber="+accountnumber+"&demo="+democode+"&equity="+equity+"&balance="+balance+"&version="+version+"&symbol="+sym+"&server="+server+"&company="+company+"&profit="+profit+"&credit="+credit+"&typeofanalysis="+typeofanalysis);

  }
//+------------------------------------------------------------------+

//===================================   GrabWeb Functions   =======================================
//=================================================================================================
#define READURL_BUFFER_SIZE   1000

#import "wininet.dll"
int InternetOpenW(string,int,string,string,int);
int InternetOpenUrlW(int,string,string,int,int,int);
int InternetCloseHandle(int);
int InternetReadFile(int,uchar  &arr[],int,int  &arr[]);
#import
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
// Reads the specified URL and returns the server's response. Return value is 
// a blank string if an error occurs                
string ReadUrl(string Url)
  {
   string strData= "";
   bool bSuccess = false;

// Get an internet handle
   int hInternet=InternetOpenW("mt4",0 /* 0 = INTERNET_OPEN_TYPE_PRECONFIG */,NULL,NULL,0);
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(hInternet==0)
     {
      Print("InternetOpenW() failed");

        } else {
      //+------------------------------------------------------------------+
      //|                                                                  |
      //+------------------------------------------------------------------+
      //+------------------------------------------------------------------+
      //|                                                                  |
      //+------------------------------------------------------------------+
      //+------------------------------------------------------------------+
      //|                                                                  |
      //+------------------------------------------------------------------+
      // Get a URL handle
      int hInternetUrl=InternetOpenUrlW(hInternet,Url,NULL,0,0,0);
      if(hInternetUrl==0)
        {
         Print("InternetOpenUrlW() failed");

           } else {
         // We potentially (in fact, usually) get the response in multiple chunks
         // Keep calling InternetReadFile() until it fails, or until
         // it says that the read is complete
         bool bKeepReading=true;
         while(bKeepReading)
           {
            int szRead[1];
            uchar arrReceive[];
            ArrayResize(arrReceive,READURL_BUFFER_SIZE+1);
            int success=InternetReadFile(hInternetUrl,arrReceive,READURL_BUFFER_SIZE,szRead);

            if(success==0)
              {
               Print("InternetReadFile() failed");
               bKeepReading=false;

                 } else {
               // InternetReadFile() has succeeded, but we may be at the end of the data 
               if(szRead[0]==0)
                 {
                  bKeepReading=false;
                  bSuccess=true;

                    } else {
                  // Convert the data from Ansi to Unicode using the built-in MT4 function
                  string strThisRead=CharArrayToString(arrReceive,0,szRead[0],CP_UTF8);
                  strData=StringConcatenate(strData,strThisRead);  // <-- PROBLEM HERE ON FIRST USE ONLY IN EACH MT4 SESSION
                 }
              }
           }
         InternetCloseHandle(hInternetUrl);
        }
      InternetCloseHandle(hInternet);
     }

   return (strData);
  }//+------------------------------------------------------------------+
