#!/bin/sh
set -e
make pdf || echo 'Already built'
# PDF
mv board-resolutions.pdf Board-Resolutions.pdf
mv bylaws.pdf Bylaws.pdf
mv certificate.pdf Certificate-of-Incorporation.pdf
mv consent.pdf Receipt-and-Consent.pdf
mv election.pdf 83b-Election.pdf
mv incorporator.pdf Action-of-Incorporator.pdf
mv incorporator-cert.pdf Incorporator-Bylaws-Certificate.pdf
mv indem-agreement.pdf Indemnification-Agreement.pdf
mv indem-resolutions.pdf Stockholder-Consent.pdf
mv purchase-agreement-double-cash.pdf Stock-Purchase-Agreement-Double-Trigger-Cash.pdf
mv purchase-agreement-double-ip.pdf Stock-Purchase-Agreement-Double-Trigger-IP.pdf
mv purchase-agreement-double-mixed.pdf Stock-Purchase-Agreement-Double-Trigger-Mixed.pdf
mv purchase-agreement-single-cash.pdf Stock-Purchase-Agreement-Single-Trigger-Cash.pdf
mv purchase-agreement-single-ip.pdf Stock-Purchase-Agreement-Single-Trigger-IP.pdf
mv purchase-agreement-single-mixed.pdf Stock-Purchase-Agreement-Single-Trigger-Mixed.pdf
mv receipt.pdf Receipt.pdf
mv secretary-cert.pdf Secretary-Bylaws-Certificate.pdf
mv statement.pdf 83b-Statements-and-Acknowledgement.pdf
mv stock-power.pdf Stock-Power.pdf
# DOCX
mv board-resolutions.docx Board-Resolutions.docx
mv bylaws.docx Bylaws.docx
mv certificate.docx Certificate-of-Incorporation.docx
mv consent.docx Receipt-and-Consent.docx
mv election.docx 83b-Election.docx
mv incorporator.docx Action-of-Incorporator.docx
mv incorporator-cert.docx Incorporator-Bylaws-Certificate.docx
mv indem-agreement.docx Indemnification-Agreement.docx
mv indem-resolutions.docx Stockholder-Consent.docx
mv purchase-agreement-double-cash.docx Stock-Purchase-Agreement-Double-Trigger-Cash.docx
mv purchase-agreement-double-ip.docx Stock-Purchase-Agreement-Double-Trigger-IP.docx
mv purchase-agreement-double-mixed.docx Stock-Purchase-Agreement-Double-Trigger-Mixed.docx
mv purchase-agreement-single-cash.docx Stock-Purchase-Agreement-Single-Trigger-Cash.docx
mv purchase-agreement-single-ip.docx Stock-Purchase-Agreement-Single-Trigger-IP.docx
mv purchase-agreement-single-mixed.docx Stock-Purchase-Agreement-Single-Trigger-Mixed.docx
mv receipt.docx Receipt.docx
mv secretary-cert.docx Secretary-Bylaws-Certificate.docx
mv statement.docx 83b-Statements-and-Acknowledgement.docx
mv stock-power.docx Stock-Power.docx
