#include "hex2int.h"

int hexalpha_to_int(int c)
{
  char hexalpha[] = "aAbBcCdDeEfF";
  int i;
  int answer = 0;

  for(i = 0; answer == 0 && hexalpha[i] != '\0'; i++)
  {
    if(hexalpha[i] == c)
    {
      answer = 10 + (i / 2);
    }
  }

  return answer;
}

unsigned int htoi(const char s[])
{
  unsigned int answer = 0;
  int i = 0;
  int valid = 1;
  int hexit;

  if(s[i] == '0')
  {
    ++i;
    if(s[i] == 'x' || s[i] == 'X')
    {
      ++i;
    }
  }

  while(valid && s[i] != '\0')
  {
    answer = answer * 16;
    if(s[i] >= '0' && s[i] <= '9')
    {
      answer = answer + (s[i] - '0');
    }
    else
    {
      hexit = hexalpha_to_int(s[i]);
      if(hexit == 0)
      {
        valid = 0;
      }
      else
      {
        answer = answer + hexit;
      }
    }

    ++i;
  }

  if(!valid)
  {
    answer = 0;
  }

  return answer;
}
