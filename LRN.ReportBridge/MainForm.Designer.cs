using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

namespace ExcelETLWinApp
{
    partial class MainForm
    {
        private System.ComponentModel.IContainer components = null;
        private System.Windows.Forms.TabControl tabControl;
        private System.Windows.Forms.TabPage tabUpload;
        private System.Windows.Forms.TabPage tabDownload;
        private System.Windows.Forms.TabPage tabETL;
        private System.Windows.Forms.ComboBox cmbUploadReportType;
        private System.Windows.Forms.Button btnSelectFile;
        private System.Windows.Forms.TextBox txtFile;
        private System.Windows.Forms.Button btnUpload;
        private System.Windows.Forms.ComboBox cmbDownloadReportType;
        private System.Windows.Forms.Button btnDownload;
        private System.Windows.Forms.Button btnRunETL;
      
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
                components.Dispose();
            base.Dispose(disposing);
        }

        private void InitializeComponent()
        {
            tabControl = new TabControl();
            tabUpload = new TabPage();
            cmbUploadReportType = new ComboBox();
            btnSelectFile = new Button();
            txtFile = new TextBox();
            btnUpload = new Button();
            tabDownload = new TabPage();
            cmbDownloadReportType = new ComboBox();
            btnDownload = new Button();
            tabETL = new TabPage();
            btnRunETL = new Button();
            tabPage1 = new TabPage();
            btnProcessMultiple = new Button();
            txtFilesURL = new TextBox();
            txtFilesPath = new TextBox();
            label3 = new Label();
            label1 = new Label();
            label2 = new Label();
            tabControl.SuspendLayout();
            tabUpload.SuspendLayout();
            tabDownload.SuspendLayout();
            tabETL.SuspendLayout();
            tabPage1.SuspendLayout();
            SuspendLayout();
            // 
            // tabControl
            // 
            tabControl.Controls.Add(tabUpload);
            tabControl.Controls.Add(tabDownload);
            tabControl.Controls.Add(tabETL);
            tabControl.Controls.Add(tabPage1);
            tabControl.Location = new Point(12, 12);
            tabControl.Name = "tabControl";
            tabControl.SelectedIndex = 0;
            tabControl.Size = new Size(520, 300);
            tabControl.TabIndex = 0;
            // 
            // tabUpload
            // 
            tabUpload.Controls.Add(cmbUploadReportType);
            tabUpload.Controls.Add(btnSelectFile);
            tabUpload.Controls.Add(txtFile);
            tabUpload.Controls.Add(btnUpload);
            tabUpload.Location = new Point(4, 29);
            tabUpload.Name = "tabUpload";
            tabUpload.Size = new Size(512, 267);
            tabUpload.TabIndex = 0;
            tabUpload.Text = "Upload";
            tabUpload.UseVisualStyleBackColor = true;
            // 
            // cmbUploadReportType
            // 
            cmbUploadReportType.DropDownStyle = ComboBoxStyle.DropDownList;
            cmbUploadReportType.Location = new Point(20, 20);
            cmbUploadReportType.Name = "cmbUploadReportType";
            cmbUploadReportType.Size = new Size(300, 28);
            cmbUploadReportType.TabIndex = 0;
            // 
            // btnSelectFile
            // 
            btnSelectFile.Location = new Point(20, 60);
            btnSelectFile.Name = "btnSelectFile";
            btnSelectFile.Size = new Size(100, 35);
            btnSelectFile.TabIndex = 1;
            btnSelectFile.Text = "Select File";
            btnSelectFile.Click += btnSelectFile_Click;
            // 
            // txtFile
            // 
            txtFile.Location = new Point(130, 68);
            txtFile.Name = "txtFile";
            txtFile.ReadOnly = true;
            txtFile.Size = new Size(300, 27);
            txtFile.TabIndex = 2;
            // 
            // btnUpload
            // 
            btnUpload.Location = new Point(318, 117);
            btnUpload.Name = "btnUpload";
            btnUpload.Size = new Size(112, 38);
            btnUpload.TabIndex = 3;
            btnUpload.Text = "Upload";
            btnUpload.Click += btnUpload_Click;
            // 
            // tabDownload
            // 
            tabDownload.Controls.Add(cmbDownloadReportType);
            tabDownload.Controls.Add(btnDownload);
            tabDownload.Location = new Point(4, 29);
            tabDownload.Name = "tabDownload";
            tabDownload.Size = new Size(512, 267);
            tabDownload.TabIndex = 1;
            tabDownload.Text = "Download";
            tabDownload.UseVisualStyleBackColor = true;
            // 
            // cmbDownloadReportType
            // 
            cmbDownloadReportType.DropDownStyle = ComboBoxStyle.DropDownList;
            cmbDownloadReportType.Location = new Point(20, 20);
            cmbDownloadReportType.Name = "cmbDownloadReportType";
            cmbDownloadReportType.Size = new Size(300, 28);
            cmbDownloadReportType.TabIndex = 0;
            // 
            // btnDownload
            // 
            btnDownload.Location = new Point(20, 60);
            btnDownload.Name = "btnDownload";
            btnDownload.Size = new Size(98, 33);
            btnDownload.TabIndex = 1;
            btnDownload.Text = "Download";
            btnDownload.Click += btnDownload_Click;
            // 
            // tabETL
            // 
            tabETL.Controls.Add(btnRunETL);
            tabETL.Location = new Point(4, 29);
            tabETL.Name = "tabETL";
            tabETL.Size = new Size(512, 267);
            tabETL.TabIndex = 2;
            tabETL.Text = "ETL Processor";
            tabETL.UseVisualStyleBackColor = true;
            // 
            // btnRunETL
            // 
            btnRunETL.Location = new Point(20, 20);
            btnRunETL.Name = "btnRunETL";
            btnRunETL.Size = new Size(135, 35);
            btnRunETL.TabIndex = 0;
            btnRunETL.Text = "Run ETL Process";
            btnRunETL.Click += btnRunETL_Click;
            // 
            // tabPage1
            // 
            tabPage1.Controls.Add(btnProcessMultiple);
            tabPage1.Controls.Add(txtFilesURL);
            tabPage1.Controls.Add(txtFilesPath);
            tabPage1.Controls.Add(label3);
            tabPage1.Controls.Add(label1);
            tabPage1.Controls.Add(label2);
            tabPage1.Location = new Point(4, 29);
            tabPage1.Name = "tabPage1";
            tabPage1.Padding = new Padding(3);
            tabPage1.Size = new Size(512, 267);
            tabPage1.TabIndex = 3;
            tabPage1.Text = "Group Upload";
            tabPage1.UseVisualStyleBackColor = true;
            // 
            // btnProcessMultiple
            // 
            btnProcessMultiple.Location = new Point(117, 171);
            btnProcessMultiple.Name = "btnProcessMultiple";
            btnProcessMultiple.Size = new Size(88, 28);
            btnProcessMultiple.TabIndex = 6;
            btnProcessMultiple.Text = "Upload";
            btnProcessMultiple.UseVisualStyleBackColor = true;
            btnProcessMultiple.Click += btnProcessMultiple_Click;
            // 
            // txtFilesURL
            // 
            txtFilesURL.Location = new Point(117, 121);
            txtFilesURL.Name = "txtFilesURL";
            txtFilesURL.Size = new Size(351, 27);
            txtFilesURL.TabIndex = 5;
            // 
            // txtFilesPath
            // 
            txtFilesPath.Location = new Point(117, 23);
            txtFilesPath.Name = "txtFilesPath";
            txtFilesPath.Size = new Size(351, 27);
            txtFilesPath.TabIndex = 4;
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Location = new Point(20, 68);
            label3.Name = "label3";
            label3.Size = new Size(25, 20);
            label3.TabIndex = 3;
            label3.Text = "Or";
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new Point(22, 121);
            label1.Name = "label1";
            label1.Size = new Size(68, 20);
            label1.TabIndex = 1;
            label1.Text = "Files URL";
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(20, 23);
            label2.Name = "label2";
            label2.Size = new Size(70, 20);
            label2.TabIndex = 2;
            label2.Text = "Files Path";
            // 
            // MainForm
            // 
            ClientSize = new Size(540, 320);
            Controls.Add(tabControl);
            Name = "MainForm";
            Text = "Excel ETL WinApp";
            tabControl.ResumeLayout(false);
            tabUpload.ResumeLayout(false);
            tabUpload.PerformLayout();
            tabDownload.ResumeLayout(false);
            tabETL.ResumeLayout(false);
            tabPage1.ResumeLayout(false);
            tabPage1.PerformLayout();
            ResumeLayout(false);
        }
        private TabPage tabPage1;
        private Button btnProcessMultiple;
        private TextBox txtFilesURL;
        private TextBox txtFilesPath;
        private Label label3;
        private Label label1;
        private Label label2;
    }
}
