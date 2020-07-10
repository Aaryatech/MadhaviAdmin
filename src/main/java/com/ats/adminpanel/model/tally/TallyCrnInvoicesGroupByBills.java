package com.ats.adminpanel.model.tally;

import java.util.List;


public class TallyCrnInvoicesGroupByBills {

	List<CreditNoteInvoiceTally> creditNoteInvoices;

	public List<CreditNoteInvoiceTally> getCreditNoteInvoices() {
		return creditNoteInvoices;
	}

	public void setCreditNoteInvoices(List<CreditNoteInvoiceTally> creditNoteInvoices) {
		this.creditNoteInvoices = creditNoteInvoices;
	}

	@Override
	public String toString() {
		return "TallyCrnInvoicesGroupByBills [creditNoteInvoices=" + creditNoteInvoices + "]";
	}
	
}
