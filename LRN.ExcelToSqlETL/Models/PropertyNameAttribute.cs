using System.Globalization;

[AttributeUsage(AttributeTargets.Property)]
public class PropertyNameAttribute : Attribute
{
    public string ColumnName { get; set; }

    public string PropertyType { get; set; }
}
