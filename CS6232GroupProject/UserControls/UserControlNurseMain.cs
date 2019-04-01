﻿using CS6232GroupProject.Controller;
using CS6232GroupProject.Model;
using CS6232GroupProject.View;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Windows.Forms;

namespace CS6232GroupProject.UserControls
{
    public partial class UserControlNurseMain : UserControl
    {

        private List<Doctor> doctorList;
        private List<Patient> patientList;
        private DoctorController doctorController;
        private PatientController patientController;
        private AppointmentController appointmentController;
        /// <summary>
        /// Constructor
        /// </summary>
        public UserControlNurseMain()
        {
            InitializeComponent();
            this.doctorController = new DoctorController();
            this.patientController = new PatientController();
            this.appointmentController = new AppointmentController();
            SetComboBox();
        }

        private void SetComboBox()
        {
            try
            {
                foreach (string state in State.GetStates())
                {
                    this.comboBoxState.Items.Add(state);
                    this.comboBoxStatePatientInfoResult.Items.Add(state);
                }

                foreach (string gender in Gender.GetGender())
                {
                    this.comboBoxRegisterGender.Items.Add(gender);
                    this.comboBoxGenderPatientInfoResult.Items.Add(gender);
                }

                patientList = this.patientController.GetPatients();
                comboBoxPatient.DataSource = patientList;

                doctorList = this.doctorController.GetDoctors();
                comboBoxPhysician.DataSource = doctorList;

                //patientBindingSource.Clear();
                //patientBindingSource.Add();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, ex.GetType().ToString());
            }
        }

        /// <summary>
        /// Clear fields.
        /// </summary>
        public void ClearText()
        {
            this.textBoxRegisterFirstName.Clear();
            this.textBoxRegisterLastName.Clear();
            this.textBoxRegisterPhone.Clear();
            this.textBoxSSN.Clear();
            this.comboBoxRegisterGender.SelectedIndex = -1;
            this.textBoxRegisterStreet.Clear();
            this.dateTimePickerRegisterDOB.Value = DateTime.Now;
            this.comboBoxState.SelectedIndex = -1;
            this.textBoxRegisterZipcode.Clear();
            this.labelAddMessage.Text = "";
        }

        private bool CheckFields()
        {
            labelAddMessage.ForeColor = Color.Red;
            int number;
            int.TryParse(this.textBoxSSN.Text, out number);
            bool checkNumber = number.GetType().Equals(typeof(int));
            if (this.textBoxRegisterFirstName.Text.Length == 0 || this.textBoxRegisterFirstName.Text == null)
            {
                labelAddMessage.Text = "Please enter a First Name";
                return false;
            }
            else if (this.textBoxRegisterLastName.Text.Length == 0 || this.textBoxRegisterLastName.Text == null)
            {
                labelAddMessage.Text = "Please enter a Last Name";
                return false;
            }
            else if (this.dateTimePickerRegisterDOB.Value >= DateTime.Now)
            {
                labelAddMessage.Text = "Please enter a valid Date of Birth";
                return false;
            }
            else if (this.textBoxSSN.Text.Length < 9 || this.textBoxSSN.Text == null || !checkNumber)
            {
                labelAddMessage.Text = "Please enter a valid 9 digit SSN";
                return false;
            }
            else if (this.comboBoxRegisterGender.SelectedIndex == -1)
            {
                labelAddMessage.Text = "Please select a Gender";
                return false;
            }
            else if (this.textBoxRegisterPhone.Text.Length == 0 || this.textBoxRegisterPhone.Text == null)
            {
                labelAddMessage.Text = "Please enter a Phone Number";
                return false;
            }
            else if (this.textBoxRegisterStreet.Text.Length == 0 || this.textBoxRegisterStreet.Text == null)
            {
                labelAddMessage.Text = "Please enter a Street Address";
                return false;
            }
            else if (this.comboBoxState.SelectedIndex == -1)
            {
                labelAddMessage.Text = "Please select a State";
                return false;
            }
            else if (this.textBoxRegisterZipcode.Text.Length == 0 || this.textBoxRegisterZipcode.Text == null)
            {
                labelAddMessage.Text = "Please enter a Zip Code";
                return false;
            }
            else
            {
                labelAddMessage.Text = "";
                return true;
            }
        }

        private void buttonRegisterSubmit_Click(object sender, EventArgs e)
        {
            Patient newPatient = new Patient();
            Address newAddress = new Address();
            if (this.CheckFields())
            {
                try
                {
                    newPatient.FName = this.textBoxRegisterFirstName.Text;
                    newPatient.LName = this.textBoxRegisterLastName.Text;
                    newPatient.DOB = this.dateTimePickerRegisterDOB.Value;
                    newPatient.SSN = this.textBoxSSN.Text;
                    newPatient.Phone = this.textBoxRegisterPhone.Text;
                    newPatient.Gender = this.comboBoxRegisterGender.Text;

                    newAddress.Street = this.textBoxRegisterStreet.Text;
                    newAddress.State = this.comboBoxState.Text;
                    newAddress.Zip = Convert.ToInt32(this.textBoxRegisterZipcode.Text);
                    patientController.registerPatient(newPatient, newAddress);
                    MessageBox.Show("Patient Registered", "Confirm");
                    this.ClearText();
                }
                catch (SqlException ex)
                {
                    MessageBox.Show("Invalid. \n" + ex.Message,
                        "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            // If true, call the controller method, passing the created patient object,
            // which calls the PatientDAL method that creates a new patient in the DB.
            // Later, we can even have it check if that patient exsists already.
        }

        private void buttonSearch_Click(object sender, EventArgs e)
        {

            this.dataGridViewPatientInfo.DataSource = null;
            this.dataGridViewPatientInfo.Rows.Clear();
            Patient newPatient = new Patient();
           
             newPatient.FName = this.textBoxFirstName.Text;
             newPatient.LName = this.textBoxLastName.Text;
             newPatient.DOB = this.dateTimePickerDOB.Value;
            
                this.dataGridViewPatientInfo.DataSource = this.patientController.getPatientInformation(newPatient);
            if (this.dataGridViewPatientInfo.Rows.Count > 0) {
                panelPatientInfoResults.Visible = true;
                linkLabelPatientInfoBack.Visible = true;
            }
                
           
            /// when selected and conditions approved, Patient Info results panel and back button should then be visible
        }

        private void linkLabelPatientInfoBack_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            panelPatientInfoResults.Visible = false;
            linkLabelPatientInfoBack.Visible = false;
            /// 
        }

        private void fillByToolStripButton_Click(object sender, EventArgs e)
        {
            try
            {
                this.doctorTableAdapter.FillBy(this.clinicDataSet.Doctor);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        private void linkLabelRecordsPatientInfoVisitRecords_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            bool isOpen = false;
            FormPatientRecords formPatientRecords = new FormPatientRecords();
            foreach (Form form in Application.OpenForms)
            {
                if (form.Name == "FormPatientRecords")
                {
                    isOpen = true;
                    form.BringToFront();
                    break;
                }
            }
            if (isOpen == false)
            {
                formPatientRecords.Show();
            }

        }

        private bool CheckBookApointmentFields()
        {
            if (textBoxSummary.Text == "")
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        private void buttonBookSubmit_Click(object sender, EventArgs e)
        {
            if (CheckBookApointmentFields())
            {
                try
                {
                    var reason = textBoxSummary.Text;
                    Appointment appointment = new Appointment();
                    appointment.PatientID = Convert.ToInt32(comboBoxPatient.SelectedValue);
                    appointment.DoctorID = Convert.ToInt32(comboBoxPhysician.SelectedValue);
                    appointment.AppointmentDateTime = dateTimePickerBookAppointment.Value.Date + dateTimePickerBookAppointmentTime.Value.TimeOfDay;
                    appointment.Reasons = reason;

                    if (this.appointmentController.CheckAvailability(appointment))
                    {
                        this.appointmentController.CreateAppointment(appointment);
                        textBoxSummary.Text = "";
                        MessageBox.Show("Appointment Booked!");
                    }
                    else
                    {
                        MessageBox.Show("That Date and Time isn't available", "Date or Time Not Available");
                    }


                }
                catch (Exception ex)
                {
                    MessageBox.Show("There was an issue creating the Appointment!" + ex.Message, "Appointment Creation Error!");
                }
            }
            else
            {
                MessageBox.Show("Please enter a Reason", "Missing Information!");
            }
        }

        private void doctorBindingSource_CurrentChanged(object sender, EventArgs e)
        {

        }
    }
}
