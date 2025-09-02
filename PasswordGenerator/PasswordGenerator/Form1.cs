namespace PasswordGenerator
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Enrypt_Click(object sender, EventArgs e)
        {
            string hash = AesGcmService.Encrypt(txtPassword.Text);
            txtPasswordHash.Text = hash;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string hash = AesGcmService.Decrypt(txtPasswordHash.Text);
            txtPassword.Text = hash;
        }
    }
}
