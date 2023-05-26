// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.9;

contract MarkSheetContract {
    struct Subject {
        string code;
        string name;
        string grade;
        string result;
        string examType;
    }

    struct Student {
        string name;
        string rollno;
        string fatherName;
        string universityName;
        string collegeName;
        string degree;
        string branch;
        string status;
    }

    struct MarkSheet {
        uint timestamp;
        uint semester;
        uint year;
        string result;
        string grade;
        Student student;
        bytes32 hashValue;
        mapping(uint => Subject) subjects;
        uint subjectCount;
    }

     mapping(uint=> MarkSheet) marksheets;
     uint totalMarksheet;

    function addMarksheet( Student memory student,string memory result,string memory grade,
        uint semester,
        uint year,Subject[] memory _subjects) public {
        MarkSheet storage marksheet = marksheets[totalMarksheet++];
        marksheet.semester = semester;
        marksheet.year = year;
        marksheet.student = student;
        marksheet.grade = grade;
        marksheet.result = result;
        marksheet.timestamp = block.timestamp;
        bytes32 txHash = keccak256(abi.encode(block.number,block.timestamp, student, semester, year, _subjects));
        marksheet.hashValue = txHash;
        for(uint i = 0;i < _subjects.length;i++){
              marksheet.subjects[marksheet.subjectCount++] = _subjects[i];
        }

    }

 function getMarksheetByRollNo(string memory rollno) public view returns 
 (Student memory student, Subject[][] memory subjects, uint[] memory semester, uint[] memory year,bytes32[] memory hashes,
  string[] memory result,string[] memory grade,uint[] memory timestamp) {
        uint count = 0;
        
        for(uint i = 0; i < totalMarksheet; i++) {
           MarkSheet storage marksheet = marksheets[i];
            if (keccak256(bytes(marksheet.student.rollno)) == keccak256(bytes(rollno))) 
             count++;
        }
      
        subjects = new Subject[][](count);
        year = new uint[](count);
        semester = new uint[](count);
        hashes = new bytes32[](count);
        result = new string[](count);
        grade = new string[](count);
        timestamp = new uint[](count);
       
        count = 0;

        for (uint i = 0; i < totalMarksheet; i++) {
            MarkSheet storage marksheet = marksheets[i];
            if (keccak256(bytes(marksheet.student.rollno)) == keccak256(bytes(rollno))) {
                subjects[count] = new Subject[](marksheet.subjectCount);
                for (uint j = 0; j < marksheet.subjectCount; j++) {
                    subjects[count][j] = marksheet.subjects[j];
                }

                student = marksheet.student;
                year[count] = marksheet.year;
                semester[count] = marksheet.semester;
                hashes[count] = marksheet.hashValue;
                result[count] = marksheet.result;
                grade[count] = marksheet.grade;
                timestamp[count] = marksheet.timestamp;
                count++;
            }
        }
        return (student,subjects,year,semester,hashes,result,grade,timestamp);
    }


    function verifyMarksheet(bytes32 hashValue) public view returns( uint timestamp,uint semester,uint year,string memory result,
    string memory grade,Student memory student,Subject[] memory subjects){
          for(uint i = 0;i < totalMarksheet;i++){
               MarkSheet storage marksheet = marksheets[i];
               if(marksheet.hashValue == hashValue)
              {
                    subjects = new Subject[](marksheet.subjectCount);
                    for (uint j = 0; j < marksheet.subjectCount; j++) {
                    subjects[j] = marksheet.subjects[j];
                    }
                    return (marksheet.timestamp,marksheet.semester,marksheet.year,marksheet.result,marksheet.grade,marksheet.student,subjects);
                
              }
          }
    }

}
