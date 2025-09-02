namespace PasswordGenerator
{
    partial class Form1
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            tabPage2 = new TabPage();
            txtPassword = new TextBox();
            txtPasswordHash = new TextBox();
            label1 = new Label();
            label2 = new Label();
            Enrypt = new Button();
            button1 = new Button();
            tabControl = new TabControl();
            tabPage2.SuspendLayout();
            tabControl.SuspendLayout();
            SuspendLayout();
            // 
            // tabPage2
            // 
            tabPage2.Controls.Add(button1);
            tabPage2.Controls.Add(Enrypt);
            tabPage2.Controls.Add(label2);
            tabPage2.Controls.Add(label1);
            tabPage2.Controls.Add(txtPasswordHash);
            tabPage2.Controls.Add(txtPassword);
            tabPage2.Location = new Point(4, 29);
            tabPage2.Name = "tabPage2";
            tabPage2.Padding = new Padding(3);
            tabPage2.Size = new Size(781, 411);
            tabPage2.TabIndex = 4;
            tabPage2.Text = "Password Hash";
            tabPage2.UseVisualStyleBackColor = true;
            // 
            // txtPassword
            // 
            txtPassword.Location = new Point(153, 30);
            txtPassword.Name = "txtPassword";
            txtPassword.Size = new Size(204, 27);
            txtPassword.TabIndex = 0;
            // 
            // txtPasswordHash
            // 
            txtPasswordHash.Location = new Point(153, 88);
            txtPasswordHash.Name = "txtPasswordHash";
            txtPasswordHash.Size = new Size(204, 27);
            txtPasswordHash.TabIndex = 1;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new Point(9, 40);
            label1.Name = "label1";
            label1.Size = new Size(126, 20);
            label1.TabIndex = 2;
            label1.Text = "Decrypt Password";
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(19, 98);
            label2.Name = "label2";
            label2.Size = new Size(116, 20);
            label2.TabIndex = 3;
            label2.Text = "Enrypt Password";
            // 
            // Enrypt
            // 
            Enrypt.Location = new Point(153, 168);
            Enrypt.Name = "Enrypt";
            Enrypt.Size = new Size(138, 35);
            Enrypt.TabIndex = 4;
            Enrypt.Text = "Enrypt";
            Enrypt.UseVisualStyleBackColor = true;
            Enrypt.Click += Enrypt_Click;
            // 
            // button1
            // 
            button1.Location = new Point(314, 172);
            button1.Name = "button1";
            button1.Size = new Size(134, 31);
            button1.TabIndex = 5;
            button1.Text = "Decrypt";
            button1.UseVisualStyleBackColor = true;
            button1.Click += button1_Click;
            // 
            // tabControl
            // 
            tabControl.Controls.Add(tabPage2);
            tabControl.Font = new Font("Segoe UI", 9F);
            tabControl.Location = new Point(-1, 12);
            tabControl.Name = "tabControl";
            tabControl.SelectedIndex = 0;
            tabControl.Size = new Size(789, 444);
            tabControl.TabIndex = 1;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(tabControl);
            Name = "Form1";
            Text = "Form1";
            tabPage2.ResumeLayout(false);
            tabPage2.PerformLayout();
            tabControl.ResumeLayout(false);
            ResumeLayout(false);
        }

        #endregion

        private TabPage tabPage2;
        private Button button1;
        private Button Enrypt;
        private Label label2;
        private Label label1;
        private TextBox txtPasswordHash;
        private TextBox txtPassword;
        private TabControl tabControl;
    }
}
