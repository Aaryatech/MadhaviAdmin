package com.ats.adminpanel.model.tally;

import java.util.List;

public class TallySalesInvoiceListGroupByBills {

	List<SalesInvoices> SalesInvoices;

	public List<SalesInvoices> getSalesInvoices() {
		return SalesInvoices;
	}

	public void setSalesInvoices(List<SalesInvoices> salesInvoices) {
		SalesInvoices = salesInvoices;
	}

	@Override
	public String toString() {
		return "TallySalesInvoiceListGroupByBills [SalesInvoices=" + SalesInvoices + "]";
	}
}
