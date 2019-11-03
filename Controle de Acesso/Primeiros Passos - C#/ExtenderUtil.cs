using System;

namespace ExemploAPI
{
    public static class ExtenderUtil
    {
        /// <summary>
        /// Converte uma DateTime em Segundos desde 1/1/1970
        /// </summary>
        /// <see cref="http://pt.wikipedia.org/wiki/Era_Unix"/>
        public static long ToUnix(this DateTime dt)
        {
            if (dt == DateTime.MinValue)
                return 0;
            else
                return (long)dt.Subtract(new DateTime(1970, 1, 1)).TotalSeconds;
        }

        /// <summary>
        /// Converte os Segundos desde 1/1/1970 em uma Data
        /// </summary>
        /// <see cref="http://pt.wikipedia.org/wiki/Era_Unix"/>
        public static DateTime FromUnix(this long seconds)
        {
            if (seconds == 0)
                return DateTime.MinValue;
            else
                return new DateTime(1970, 1, 1).AddSeconds(seconds);
        }
    }
}
