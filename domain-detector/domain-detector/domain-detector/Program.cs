using System;
using System.IO;
using System.Reflection;
using System.Text.RegularExpressions;

class Program

{
    static void Main(string[] args)
    {
        string path = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "../../../", "utils", "example.txt");


        try
        {
            string contenido = File.ReadAllText(path);
            Regex regex = new Regex(@"\b(?:http?://|www\.)\S+\b", RegexOptions.Compiled | RegexOptions.IgnoreCase);
            MatchCollection matches = regex.Matches(contenido);
            string urls = "";
            foreach (Match match in matches)
            {
                string url = match.Value;
                Uri uri = new Uri(url);
                string dominio = uri.Host;

                dominio = Regex.Replace(dominio, @"^[^\.]*\.", "");
                urls += dominio + ";"; 
            }

            Console.WriteLine(urls);

        }
        catch (Exception ex)
        {
            Console.WriteLine("Ocurrió un error al leer el archivo: " + ex.Message);
        }
    }
}
